use master;

Select * from netflix_raw;

--- Data Cleaning

Select * from netflix_raw order by title;
---- Remove duplicates
Select show_id, count(*)
from netflix_raw
group by show_id
having COUNT(*)>1
---- no output hence we can make it as primary key
---- check duplicates in title column
Select title, count(*)
from netflix_raw
group by title
having COUNT(*)>1
----
Select * from netflix_raw
where concat (UPPER (title), type, director) in (
Select concat (UPPER (title), type, director)
from netflix_raw
group by upper (title),type, director
having COUNT(*)>1)
order by title
----
with cte as (
Select *
, ROW_NUMBER () over (partition by title, type, director order by title) as rn
from netflix_raw)
Select * from cte 
where rn = 1

---- For Normalization
----- New table for listed in , director, country, cast
--- Director
Select show_id, trim (value) as director
into netflix_director
from netflix_raw
cross apply string_split(director, ',')
 
--Country
Select show_id, trim (value) as country
into netflix_country
from netflix_raw
cross apply string_split(country, ',')

---Cast
Select show_id, trim (value) as cast
into netflix_cast
from netflix_raw
cross apply string_split(cast, ',')

---Genre
Select show_id, trim (value) as genre
into netflix_genre
from netflix_raw
cross apply string_split(listed_in, ',')



-----populate missing values in countries and then insert the data in country table
insert into netflix_country
Select show_id, m.country 
from netflix_raw as nr
inner join (Select director, country
from netflix_country as nc
inner join netflix_director  as nd on nc.show_id =nd.show_id
group by director,country) as m 
on nr.director = m.director
where nr.country is null

-----Remove duplicates ---data type conversion for date added and null handling in duration column and insert the cleaned data into a new table
with cte as (
Select *
, ROW_NUMBER () over (partition by title, type, director order by title) as rn
from netflix_raw)
Select show_id,type,title, cast(date_added as date)as date_added, release_year, rating
,case when duration is null then rating else duration end as duration, description
into netflix
from cte 
where rn = 1




