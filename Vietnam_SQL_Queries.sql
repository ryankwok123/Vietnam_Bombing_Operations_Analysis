--cleaning data in all tables
--need to find a way to standardize the dates
select distinct MSNDATE, Convert(date, MSNDATE) as MSNDATE_Converted
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1965]
order by MSNDATE_Converted

select distinct MSNDATE, Convert(date, MSNDATE) as MSNDATE_Converted
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1966]
order by MSNDATE_Converted

select distinct MSNDATE, Convert(date, MSNDATE) as MSNDATE_Converted
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1967]
order by MSNDATE_Converted

--leap year
select distinct MSNDATE, Convert(date, MSNDATE) as MSNDATE_Converted
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1968]
order by MSNDATE_Converted

select distinct MSNDATE, Convert(date, MSNDATE) as MSNDATE_Converted
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1969]
order by MSNDATE_Converted

--for some reason, 1970 appears to have 2 rows per date as well as one invalid date FEB 29th (1970 is not a leap year)
--when returning MSNDATE there are exactly 731 rows, 365*2 is 730 so removing the invalid date suggests dates are doubled up
--Turns out dates are formatted differently 
--For example: DISTINCT picks up 19700101 & 1/1/1970 as two different dates, but the conversion fixes this. Days in the year add to 365
select distinct MSNDATE, Try_Convert(date, MSNDATE) as MSNDATE_Converted
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1970]
--where MSNDATE is not null
order by MSNDATE_Converted
/*
with comparing_days_per_month as 
(
select distinct MSNDATE, Try_Convert(date, MSNDATE) as MSNDATE_Converted
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1970]
--order by MSNDATE_Converted
)
--counting the number of days per month to see what's going on
select DAY(EOMONTH(MSNDATE_Converted)), count(MSNDATE_Converted)/2 --divide by 2 since dates are doubled up
from comparing_days_per_month
group by EOMONTH(MSNDATE_Converted)
--order by MSNDATE_Converted
*/



--1971 has 367 rows instead of 365 
--discovered the extra entries come from february and march due to different formating in the date
--DISTINCT picks up 2/12/1971 & 19710212 as two different dates, but the conversion fixes this anyways so no biggie
--DISTINCT picks up 3/12/1971 & 19710312 as two different dates, but the conversion fixes this anyways so no biggie
select distinct MSNDATE, Convert(date, MSNDATE) as MSNDATE_Converted
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1971]
order by MSNDATE_Converted
/*
with comparing_days_per_month as 
(
select distinct MSNDATE, Convert(date, MSNDATE) as MSNDATE_Converted
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1971]
--order by MSNDATE_Converted
)
--counting the number of days per month to see what's going on
select DAY(EOMONTH(MSNDATE_Converted)), count(MSNDATE_Converted)
from comparing_days_per_month
group by EOMONTH(MSNDATE_Converted)
--order by MSNDATE_Converted
*/


--1972 has 367 rows, it's a leap year but what's the extra date? 
--using the comparing days per month query above, we can see that distinct counts Jan 28th twice, problem solved
select distinct MSNDATE, Convert(date, MSNDATE) as MSNDATE_Converted
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1972]
order by MSNDATE_Converted

/*
Another method of checking duplicates using row_number

with check_duplicate as(
select distinct MSNDATE, Convert(date, MSNDATE) as MSNDATE_Converted
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1972]
--order by MSNDATE_Converted
)
select MSNDATE, MSNDATE_Converted, ROW_NUMBER() over (partition by MSNDATE_Converted order by MSNDATE_Converted) as num_dupes
from check_duplicate
order by num_dupes desc*/

/*
with comparing_days_per_month as 
(
select distinct MSNDATE, Convert(date, MSNDATE) as MSNDATE_Converted
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1972]
--order by MSNDATE_Converted
)
--counting the number of days per month to see what's going on
select DAY(EOMONTH(MSNDATE_Converted)), count(MSNDATE_Converted)
from comparing_days_per_month
group by EOMONTH(MSNDATE_Converted)
--order by MSNDATE_Converted
*/


--1973 has 368 rows
--April 19th, May 4th, July 12th incorrect format
select distinct MSNDATE, Convert(date, MSNDATE) as MSNDATE_Converted
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1973]
order by MSNDATE_Converted
/*
with comparing_days_per_month as 
(
select distinct MSNDATE, Convert(date, MSNDATE) as MSNDATE_Converted
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1973]
--order by MSNDATE_Converted
)
--counting the number of days per month to see what's going on
select DAY(EOMONTH(MSNDATE_Converted)), count(MSNDATE_Converted)
from comparing_days_per_month
group by EOMONTH(MSNDATE_Converted)
--order by MSNDATE_Converted
*/


--1974 has 366 rows
--February 21st incorrect format
select distinct MSNDATE, Convert(date, MSNDATE) as MSNDATE_Converted
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1974]
order by MSNDATE_Converted
/*
with comparing_days_per_month as 
(
select distinct MSNDATE, Convert(date, MSNDATE) as MSNDATE_Converted
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1974]
--order by MSNDATE_Converted
)
--counting the number of days per month to see what's going on
select DAY(EOMONTH(MSNDATE_Converted)), count(MSNDATE_Converted)
from comparing_days_per_month
group by EOMONTH(MSNDATE_Converted)
--order by MSNDATE_Converted
*/


--why does the data extend past the end of the vietnam war?
--kinetic missions targeting south vietnam stop abruptly after the fall of saigon, 
--mostly nulls and a few missions in cambodia. Might be worthwhile to drop everything after April 30, 1975
select MSNDATE, Convert(date, MSNDATE) as MSNDATE_Converted, MFUNC_DESC, MFUNC_DESC_CLASS, TAKEOFFLOCATION, TGTCOUNTRY
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1975]
where MFUNC_DESC_CLASS = 'KINETIC' --AND MSNDATE_Converted <= April 30th, 1975
order by MSNDATE_Converted

---------------------------------------------------------------------------------------------------------

--combining years together to form views for visualizations
--INCOMPLETE QUERY
with combined as (
	select THOR_DATA_VIET_ID, COUNTRYFLYINGMISSION, MSNDATE
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1965]
	union 
	select THOR_DATA_VIET_ID, COUNTRYFLYINGMISSION, MSNDATE
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1966]
	--add other years to this once you figure it out
)
select *
from combined

---------------------------------------------------------------------------------------------------------

--number of missions flown by country (bar graph)
Select COUNTRYFLYINGMISSION, count(THOR_DATA_VIET_ID) as num_missions_flown_by_country
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1974]
where COUNTRYFLYINGMISSION is not null
group by COUNTRYFLYINGMISSION

---------------------------------------------------------------------------------------------------------

--number missions flown by branch 
Select MILSERVICE, count(THOR_DATA_VIET_ID) as num_missions_flown_by_branch
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1974]
where MILSERVICE is not null
group by MILSERVICE

---------------------------------------------------------------------------------------------------------

--experimenting here: determining number of missions flown per day, ordered by standardized date
select MSNDATE, Convert(date, MSNDATE) as MSNDATE_Converted, count(THOR_DATA_VIET_ID) over (partition by(MSNDate))
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1966]
order by MSNDATE_Converted

---------------------------------------------------------------------------------------------------------

--number of missions flown by each type of aircraft
select AIRCRAFT_ORIGINAL, count(AIRCRAFT_ORIGINAL) as num_missions_flown_by_aircraft
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1965]
group by AIRCRAFT_ORIGINAL 
order by num_missions_flown_by_aircraft desc

--maybe use valid aircraft root instead? Comparing aircraft original with valid aircraft root. 
--Seems like there are no nulls in either column. might just do air crafts that have flown more
--than X number of missions to make life easier, in this case used greater than 1 mission
select AIRCRAFT_ORIGINAL, VALID_AIRCRAFT_ROOT, count(AIRCRAFT_ORIGINAL) as num_missions_flown_by_aircraft, count(VALID_AIRCRAFT_ROOT) as num_missions_flown_by_validaircraft
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1965]
group by AIRCRAFT_ORIGINAL, VALID_AIRCRAFT_ROOT
having count(AIRCRAFT_ORIGINAL) > 1
order by num_missions_flown_by_validaircraft desc

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--time data is riddled with errors:
	--ambigious midnight (24:00 exists as well as 00:00)
	--several data entry errors, 24:00 should actually be 00:00, 15:70 doesn't exist probably misread 2 as 7
	--nonsensical time values such as 61:41 are prevalent 

--you can still use this time data but with heavy filtering involved 
--(ie, cutting out all nulls and only including valid values for the sake of demonstration)

/*
--calculate average mission duration for each aircraft 
select try_cast(TIMEONTARGET as time), TIMEOFFTARGET
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1965]


--manipulating by inserting colons so that the values can be converted to datetime
--what should we do with zeros and nulls? 
with format_time as (
select TIMEONTARGET,
CASE
    WHEN len(TIMEONTARGET) = 4 THEN LEFT(timeontarget,2) + ':' + RIGHT(timeontarget,2) --insert colon in the middle
    WHEN len(TIMEONTARGET) = 3 THEN LEFT(timeontarget,1) + ':' + RIGHT(timeontarget,2) --insert colon in the middle
    WHEN len(TIMEONTARGET) = 2 THEN '00:' + TIMEONTARGET --add two zeros then insert colon (assuming minutes) 
	WHEN len(TIMEONTARGET) = 1 THEN '00:0' + TIMEONTARGET --add two zeros then colon then zero again (assuming minutes)
END as TIMEONTARGET_Formatted,

TIMEOFFTARGET,
CASE
    WHEN len(TIMEOFFTARGET) = 4 THEN LEFT(TIMEOFFTARGET,2) + ':' + RIGHT(TIMEOFFTARGET,2) --insert colon in the middle
    WHEN len(TIMEOFFTARGET) = 3 THEN LEFT(TIMEOFFTARGET,1) + ':' + RIGHT(TIMEOFFTARGET,2) --insert colon in the middle
    WHEN len(TIMEOFFTARGET) = 2 THEN '00:' + TIMEOFFTARGET --add two zeros then insert colon (assuming minutes) 
	WHEN len(TIMEOFFTARGET) = 1 THEN '00:0' + TIMEOFFTARGET --add two zeros then colon then zero again (assuming minutes)
END as TIMEOFFTARGET_Formatted
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1965]
--where len(TIMEONTARGET) = 1 and TIMEONTARGET <> 0
), 
--second cte
time_diff as (
select TIMEONTARGET, TIMEONTARGET_Formatted, try_cast(TIMEONTARGET_Formatted as time) as TIMEONTARGET_Converted,
TIMEOFFTARGET, TIMEOFFTARGET_Formatted, try_cast(TIMEOFFTARGET_Formatted as time) as TIMEOFFTARGET_Converted
from format_time
)
--calculate the minute difference between time on and time off, datediff???
select TIMEONTARGET, TIMEONTARGET_Formatted, TIMEONTARGET_Converted, TIMEOFFTARGET, TIMEOFFTARGET_Formatted, TIMEOFFTARGET_Converted, 
datediff(minute, TIMEONTARGET_Converted, TIMEOFFTARGET_Converted) as time_diff_mins
from time_diff
order by time_diff_mins 
--a lot of nulls where there shouldn't be, these are invalid times 
--(ie. 24:00 should actually be 00:00, 15:70 doesn't exist probably misread 2 as 7 *facepalm*)
--getting picked up as values by the LEN() function
--also, negative time diff values need to be fixed
*/

-------------------------------------------------------------------------------------------------------------------------------------------------

--looking at the period of day missions took place in
--Day: D, Night: N, Evening: E, Morning: M
--need to standardize the missions so that evening missions are night and morning missions are day (1965-1970)
--for the visualization, drop all the other labels other than day and night after the standardization
select PERIODOFDAY, count(PERIODOFDAY) as PERIODOFDAY_Count
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1965]
group by PERIODOFDAY
order by PERIODOFDAY_Count desc

--Standardizing the Morning and Night Values 
--do this for all tables!!!
select PERIODOFDAY, 
CASE
    WHEN PERIODOFDAY = 'M' THEN 'D' 
    WHEN PERIODOFDAY = 'E' THEN 'N'
	ELSE PERIODOFDAY
END as PERIODOFDAY_Standardized
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1965]
WHERE PERIODOFDAY IN('M', 'E')
ORDER BY PERIODOFDAY_Standardized

--Standardizing the Morning and Night Values 
--do this for all tables!!!
select PERIODOFDAY, 
CASE
    WHEN PERIODOFDAY = 'M' THEN 'D' 
    WHEN PERIODOFDAY = 'E' THEN 'N'
	ELSE PERIODOFDAY
END as PERIODOFDAY_Standardized
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1966]
WHERE PERIODOFDAY IN('M', 'E')
ORDER BY PERIODOFDAY_Standardized

--Standardizing the Morning and Night Values 
--do this for all tables!!!
select PERIODOFDAY, 
CASE
    WHEN PERIODOFDAY = 'M' THEN 'D' 
    WHEN PERIODOFDAY = 'E' THEN 'N'
	ELSE PERIODOFDAY
END as PERIODOFDAY_Standardized
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1967]
WHERE PERIODOFDAY IN('M', 'E')
ORDER BY PERIODOFDAY_Standardized

--Standardizing the Morning and Night Values 
--do this for all tables!!!
select PERIODOFDAY, 
CASE
    WHEN PERIODOFDAY = 'M' THEN 'D' 
    WHEN PERIODOFDAY = 'E' THEN 'N'
	ELSE PERIODOFDAY
END as PERIODOFDAY_Standardized
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1968]
WHERE PERIODOFDAY IN('M', 'E')
ORDER BY PERIODOFDAY_Standardized

--Standardizing the Morning and Night Values 
--do this for all tables!!!
select PERIODOFDAY, 
CASE
    WHEN PERIODOFDAY = 'M' THEN 'D' 
    WHEN PERIODOFDAY = 'E' THEN 'N'
	ELSE PERIODOFDAY
END as PERIODOFDAY_Standardized
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1969]
WHERE PERIODOFDAY IN('M', 'E')
ORDER BY PERIODOFDAY_Standardized

--Standardizing the Morning and Night Values 
--do this for all tables!!!
select PERIODOFDAY, 
CASE
    WHEN PERIODOFDAY = 'M' THEN 'D' 
    WHEN PERIODOFDAY = 'E' THEN 'N'
	ELSE PERIODOFDAY
END as PERIODOFDAY_Standardized
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1970]
WHERE PERIODOFDAY IN('M', 'E')
ORDER BY PERIODOFDAY_Standardized

--Standardizing the Morning and Night Values 
--do this for all tables!!!
select PERIODOFDAY, 
CASE
    WHEN PERIODOFDAY = 'M' THEN 'D' 
    WHEN PERIODOFDAY = 'E' THEN 'N'
	ELSE PERIODOFDAY
END as PERIODOFDAY_Standardized
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1971]
WHERE PERIODOFDAY IN('M', 'E')
ORDER BY PERIODOFDAY_Standardized

--Standardizing the Morning and Night Values 
--do this for all tables!!!
select PERIODOFDAY, 
CASE
    WHEN PERIODOFDAY = 'M' THEN 'D' 
    WHEN PERIODOFDAY = 'E' THEN 'N'
	ELSE PERIODOFDAY
END as PERIODOFDAY_Standardized
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1972]
WHERE PERIODOFDAY IN('M', 'E')
ORDER BY PERIODOFDAY_Standardized

--Standardizing the Morning and Night Values 
--do this for all tables!!!
select PERIODOFDAY, 
CASE
    WHEN PERIODOFDAY = 'M' THEN 'D' 
    WHEN PERIODOFDAY = 'E' THEN 'N'
	ELSE PERIODOFDAY
END as PERIODOFDAY_Standardized
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1973]
WHERE PERIODOFDAY IN('M', 'E')
ORDER BY PERIODOFDAY_Standardized

--Standardizing the Morning and Night Values 
--do this for all tables!!!
select PERIODOFDAY, 
CASE
    WHEN PERIODOFDAY = 'M' THEN 'D' 
    WHEN PERIODOFDAY = 'E' THEN 'N'
	ELSE PERIODOFDAY
END as PERIODOFDAY_Standardized
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1974]
WHERE PERIODOFDAY IN('M', 'E')
ORDER BY PERIODOFDAY_Standardized

--Standardizing the Morning and Night Values 
--do this for all tables!!!
select PERIODOFDAY, 
CASE
    WHEN PERIODOFDAY = 'M' THEN 'D' 
    WHEN PERIODOFDAY = 'E' THEN 'N'
	ELSE PERIODOFDAY
END as PERIODOFDAY_Standardized
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1965]
WHERE PERIODOFDAY IN('M', 'E')
ORDER BY PERIODOFDAY_Standardized
---------------------------------------------------------------------------------------------------------
--Operations by day on a map filter by country (geo)
select TGTLONDDD_DDD_WGS84, TGTLATDD_DDD_WGS84
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1965]
