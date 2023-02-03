--Creating views for visualizations on tableau


--# of total missions flown by country (bar) (Sorting by kinetic vs. non-kinetic missions)

--aggregating data from all years
--union to combine total num missions (both kinetic and nonkinetic, non-null) over the years 
with All_missions_flown as (
	select THOR_DATA_VIET_ID, MSNDATE, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1965]
	union 
	select THOR_DATA_VIET_ID, MSNDATE, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1966]
	union
	select THOR_DATA_VIET_ID, MSNDATE, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1967]
	union
	select THOR_DATA_VIET_ID, MSNDATE, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1968]
	union
	select THOR_DATA_VIET_ID, MSNDATE, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1969]
	union
	select THOR_DATA_VIET_ID, MSNDATE, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1970]
	union
	select THOR_DATA_VIET_ID, MSNDATE, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1971]
	union
	select THOR_DATA_VIET_ID, MSNDATE, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1972]
	union
	select THOR_DATA_VIET_ID, MSNDATE, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1973]
	union
	select THOR_DATA_VIET_ID, MSNDATE, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1974]
	union
	select THOR_DATA_VIET_ID, MSNDATE, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1975]
)
select COUNTRYFLYINGMISSION, count(THOR_DATA_VIET_ID) as num_missions_flown_by_country
from All_missions_flown
where COUNTRYFLYINGMISSION is not null --MFUNC_DESC_CLASS = 'KINETIC'
group by COUNTRYFLYINGMISSION
order by num_missions_flown_by_country desc

--create a view for the # of total missions flown by country (bar)

Create View num_missions_flown_by_country as
--insert above query here
with All_missions_flown as (
	select THOR_DATA_VIET_ID, MSNDATE, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1965]
	union 
	select THOR_DATA_VIET_ID, MSNDATE, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1966]
	union
	select THOR_DATA_VIET_ID, MSNDATE, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1967]
	union
	select THOR_DATA_VIET_ID, MSNDATE, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1968]
	union
	select THOR_DATA_VIET_ID, MSNDATE, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1969]
	union
	select THOR_DATA_VIET_ID, MSNDATE, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1970]
	union
	select THOR_DATA_VIET_ID, MSNDATE, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1971]
	union
	select THOR_DATA_VIET_ID, MSNDATE, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1972]
	union
	select THOR_DATA_VIET_ID, MSNDATE, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1973]
	union
	select THOR_DATA_VIET_ID, MSNDATE, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1974]
	union
	select THOR_DATA_VIET_ID, MSNDATE, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1975]
)
select COUNTRYFLYINGMISSION, count(THOR_DATA_VIET_ID) as num_missions_flown_by_country
from All_missions_flown
where COUNTRYFLYINGMISSION is not null --MFUNC_DESC_CLASS = 'KINETIC'
group by COUNTRYFLYINGMISSION
--order by num_missions_flown_by_country desc
