import pandas as pd
import os
import numpy as np
import re

path = '/../'

# break the 1.5 gb thor_data_vietnam.csv file into individual files by year
def fix_year(x):
    y = re.match(r'19\d{2}', str(x)).group()
    return y
   
        
with open('%sthor_data_vietnam.csv' % path) as f:
    counter = 1
    
    for chunk in pd.read_csv(f, chunksize= 10**6):
        chunk['Year'] = chunk.MSNDATE.apply(fix_year)
        
        print '#' * 75, '\n', 'CHUNK: ', counter       
        
        for i, year in enumerate(chunk.Year.value_counts().keys()):
            
            file = 'VietNam_%s.csv' % year 
            if os.path.isfile(file):
                with open(file) as f:
                    df = pd.read_csv(f)
                    df = df.append(chunk[chunk.Year == year], ignore_index=True)
                    print('_' * 75, '\n', "append", year, ':', counter, 
                            '\n', '_' * 75)
                                                      
                df.to_csv(file, index=False)
                del(df)
                                            
            else:
                chunk[chunk.Year == year].to_csv(file, index=False) 
        
        counter += 1

# break down years into files smaller than 100 mb

splits = {'VietNam_1966' : 2,
          'VietNam_1967' : 3,
          'VietNam_1968' : 4,
          'VietNam_1969' : 3,
          'VietNam_1970' : 3,
          'VietNam_1971' : 2,
          'VietNam_1972' : 2}
          
for i in splits.iteritems():
    datafile = i[0] + '.csv'
    name = i[0]
    splits = i[1]
    
    with open(datafile) as f:
        df = pd.read_csv(f)
        
    try:
        df = df.drop(['Unnamed: 0]'], axis=1)
    except:
        None
    
    chunk = len(df.index) / splits
    start = 0
    end = chunk + 1
    
    for i in range(splits):
            
        sdf = df.iloc[start:end, :]
        sdf.to_csv('%s_%d.csv' % (name, i), index=False) 
        del(sdf)

        start += chunk
        end += chunk
