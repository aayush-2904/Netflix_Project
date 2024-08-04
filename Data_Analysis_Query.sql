---Data analysis
--Ques 1  for each director count the no of movies and tv shows created by them in separate columns for directors who have created tv shows and movies both 
Select nd.director,
count(distinct case when n.type = 'Movie' then n.show_id  end) as no_of_movies,
count (distinct case when n.type = 'TV Show' then n.show_id  end) as no_of_TV_show
from netflix n
inner join netflix_director nd on n.show_id = nd.show_id
group by nd.director
having count(distinct n.type)>1;

----- Ques2 which country has highest number of comedy movies 
Select  top 1 nc.country ,count(distinct ng.show_id)as no_of_comedy_movies
 from netflix_genre ng
 inner join netflix_country nc  on ng.show_id = nc.show_id
 inner join netflix n on n.show_id = ng.show_id
where ng.genre = 'Comedies'    and n.type = 'Movie'
group by nc.country
order by no_of_comedy_movies desc;

-------Ques3 for each year (as per date added to netflix), which director has maximum number of movies released
with cte as (
Select nd.director, YEAR(n.date_added) as date_year, count( n.show_id) as no_of_movies
from netflix n
inner join netflix_director nd on n.show_id = nd.show_id
where type ='Movie'
group by nd.director, YEAR(n.date_added))
--order by no_of_movies desc
, cte2 as (
Select*
, ROW_NUMBER() over (partition by  date_year  order by no_of_movies desc, director ) as rn
from cte) 

Select * from cte2
where rn =1


-----Ques 4 what is average duration of movies in each genre
Select ng.genre , Avg (cast (REPLACE(n.duration, 'min', ' ') as int))  as duration_int
from netflix n
inner join netflix_genre ng on n.show_id = ng.show_id
where type = 'Movie'
group by ng.genre

-----Ques 5  find the list of directors who have created horror and comedy movies both.
-- display director names along with number of comedy and horror movies directed by them 
Select nd.director
,sum ( case when ng.genre= 'Comedies' then 1 else 0 end) as no_of_comedy_movies
, sum ( case when ng.genre= 'Horror Movies' then 1 else 0 end) as no_of_horror_movies
from netflix n
inner join netflix_genre ng on n.show_id = ng.show_id
inner join netflix_director nd on n.show_id = nd.show_id
where n.type = 'Movie' and ng.genre in ('Comedies' , 'Horror Movies')
group by nd.director
having count(distinct ng.genre) = 2