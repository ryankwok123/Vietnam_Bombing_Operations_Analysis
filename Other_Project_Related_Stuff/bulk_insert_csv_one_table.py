import os
import pypyodbc as odbc # pip install pypyodbc

def bulk_insert(date_file, target_table):
    sql = f"""
        BULK INSERT {target_table}
        FROM '{date_file}'
        WITH
        (   
            FORMAT='CSV',
            FIRSTROW = 2, 
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\\n'
        )    
    """.strip()
    return sql

# Step 1. Establish SQL Server Connection
SERVICE_NAME = 'DESKTOP-K1A43U8\SQLEXPRESS'#FILL THIS IN
DATABASE_NAME = 'Vietnam_Bombing_Operations'#FILL THIS IN
target_table = 'VietNam_19__' #FILL THIS IN

conn = odbc.connect(f"""
    Driver={{SQL Server}};
    Server={SERVICE_NAME};
    Database={DATABASE_NAME};
    # uid=<user id>;
    # pwd=<password>;
""".strip())
print(conn)

# Step 2. Iterate through data files and upload
data_file_folder = os.path.join(os.getcwd(), 'Vietnam_19__') # ENTER PATH TO CSV FILES HERE
data_files = os.listdir(data_file_folder)
print(data_files)

cursor = conn.cursor()
try:
    # here we can use with statement to automatically close connection once the operation is complete
    with cursor:
        for data_file in data_files:
            if data_file.endswith('.csv'):
                cursor.execute(bulk_insert(os.path.join(data_file_folder, data_file), target_table))
                print(os.path.join(data_file_folder, data_file), target_table + ' inserted')
        cursor.commit()
except Exception as e:
    print(e)
    conn.rollback()
    print('Transaction rollback')

