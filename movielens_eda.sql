/* SQL explanatory data analysis questions:



7. What is the year distribution of the movies? Do you have a favorite film? Which year is it from? How many movies from this year are visible in the movies dataset?

Display the count of movies that were released in 2003.

8. What is the year distribution of the movies? Do we have more movies from recent years? Do we have any movies from earlier years?

Find all movies with a year lower 1910.

9. Have you ever watched Star Wars? Or is there a different series of movies that you loved. Let’s see which of these movies are in the dataset.

Retrieve all Star Wars movies from the movie table.*/


-- Displaying the data structure of "movies" table. 
select * from movies;

-- Displaying the 10 first movies names and genre (sorted alphabetically)
select title, genres from movies where title like 'A%' order by title asc limit 10;

--Total row of movies in dataframe
select count(*) from movies;

-- Exploring the genres columns for 'Drama'
select distinct(genres)from movies;
select * from movies where genres like 'Drama' order by title asc limit 10;		-- Display first 10 pure Drama movies.
select count(*) from movies where genres like 'Drama'; 	-- Display the count of pure Drama movies.

select * from movies where genres like '%Drama%' order by title asc limit 10;	-- Movies have drama as one of the assigned genres
select count(*) from movies where genres like '%Drama%';

--6. What is the count of movies that are not classified as drama movies?
-- Display the count of movies don’t have drama (in any combination) as assigned genre
select * from movies where genres != '%Drama%';
select count(*) from movies where genres != '%Drama%';


-- 7. What is the year distribution of the movies? Do you have a favorite film?
-- Which year is it from? How many movies from this year are visible in the movies dataset?
-- Display the count of movies that were released in 2003.
select * from movies where title like '%Magnolia%';
select count(*) from movies where year = '1999';
select count(*) from movies where year = '2003';

--8. What is the year distribution of the movies? 
-- Do we have more movies from recent years? Do we have any movies from earlier years?
-- Find all movies with a year lower 1910.
select distinct year from movies order by year desc; 	-- no data from 2018
select * from movies where year < '1910';

--9. Have you ever watched Star Wars? Or is there a different series of movies that 
-- you loved. Let’s see which of these movies are in the dataset.
-- Retrieve all Star Wars movies from the movie table.*/
select * from movies where title like '%Star Wars%';





select movies.title, count(ratings.movieid), round(avg (ratings.rating),2), movies.year from ratings
full join movies
on ratings.movieid = movies.movieid
full join tags
on ratings.movieid = tags.movieid
where (movies.title like '%Magnolia%') or (movies.title like '%Magnolia') or (movies.title like 'Magnolia')
group by movies.title, movies.year
having count(ratings.movieid)>=50
order by round desc
limit 10;

