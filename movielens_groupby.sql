--Displaying a short preview for the tables
select * from ratings limit 10;
select * from movies limit 10;
select * from tags limit 10;
select * from links limit 10;


--Count of ratings in the table 'ratings'
select count(rating) from ratings;
select count(*) from ratings;

--Count of the different combinations of genres in 'movies' table
select count(distinct genres) from movies;

--The different tags for movie with id equal 60756
select count(distinct tag) from tags;
select distinct tag from tags where movieid=60756;
select * from movies where movieid=60756; 		-- The movie name being Step Brothers

--Count of movies in the years 1990-2000 using the movies table
select year, count(year) from movies 
group by year 
having year between 1990 and 2000;

--Displaying the year that has the highest number of movies.
create view movies_years as
select year, count(year) from movies 
group by year
order by count desc; -- 2022 having the most movies.

select * from movies where year = 2002;

--The 10 most popular movies (movies that received the most ratings)
select movies.title, count(ratings.movieid) from ratings
full join movies
on ratings.movieid = movies.movieid
group by movies.title
order by count desc
limit 10;



--The 10 most popular movies (highest ratings from movies that received at least 50 ratings)
select movies.title, count(ratings.movieid), avg(ratings.rating) from ratings
full join movies
on ratings.movieid = movies.movieid
group by movies.title
having count(ratings.movieid)>=50
order by avg desc
limit 10;


--Creation and short display of view for all the movies having 'Drama' as a genre.
create view movies_drama as
select * from movies where genres like '%Drama%';
select * from movies_drama limit 10;


-- The 10 most popular comedy movies 
-- (highest ratings from movies that received at least 100 ratings)
select movies.title, count(ratings.movieid), avg(ratings.rating) from ratings
full join movies
on ratings.movieid = movies.movieid
where movies.genres like '%Comedy%'
group by movies.title
having count(ratings.movieid)>=100
order by avg desc
limit 10;

-- The 10 most popular drama movies 
-- (highest ratings from movies that received at least 100 ratings)
select movies.title, count(ratings.movieid), avg(ratings.rating) from ratings
full join movies
on ratings.movieid = movies.movieid
where movies.genres like '%Drama%'
group by movies.title
having count(ratings.movieid)>=100
order by avg desc
limit 10;


-- The 10 most popular movies with the tags selection (joining three tables together) 
-- (highest ratings from movies that received at least 50 ratings)

select tag, count(tag) from tags 
group by tag 
order by count(tag) desc;		-- exploring popular tags -- making a wordcloud
								-- https://www.kaggle.com/code/mchirico/quick-look-seaborn-wordcloud


-- Tags : atmospheric
select movies.title, count(ratings.movieid), avg(ratings.rating) from ratings
full join movies
on ratings.movieid = movies.movieid
full join tags
on ratings.movieid = tags.movieid
where tags.tag like '%atmospheric%'
group by movies.title
having count(ratings.movieid)>=50
order by avg desc
limit 10;




/*    To separate the genres
select unnest (string_to_array (movies.genres, '|') as genre
from movies 
group by
genre;
*/ 



