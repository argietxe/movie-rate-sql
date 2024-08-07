


-- From IMDB, display the 5 first movies added to the platform
select links.movieid
		,imdbid
		,title
		from links
		join movies
		on links.movieid = movies.movieid
		order by imdbid asc
		limit 5;
		
	
-- Count of drama movies - based on the previously created view
select count(*) from movies_drama;



-- The movies attached to the tag 'fun'
select movies.title, tags.tag from movies
full join tags
on movies.movieid = tags.movieid
where (tags.tag like '%fun%') or (tags.tag like 'fun');


-- Movies that don't have any tags attached to it
select movies.title, tags.tag from movies
full join tags
on movies.movieid = tags.movieid
where tags.tag is null;



-- The 3 highest rated movie genres (with at least 100 ratings entry) 
select movies.genres, count(ratings.movieid), avg(ratings.rating) from ratings
full join movies
on ratings.movieid = movies.movieid
group by movies.genres
having count(ratings.movieid)>=100
order by avg desc
limit 5;


-- Top 10 most popular movies (based on the count of ratings on the movies)
select movies.title, count(ratings.movieid) from ratings
full join movies
on ratings.movieid = movies.movieid
group by movies.title
order by count desc
limit 10;


-- The top rated Star Wars movies
select movies.title, avg(ratings.rating) from ratings
full join movies
on ratings.movieid = movies.movieid
where (movies.title like '%Star Wars%') or (movies.title like 'Star Wars%')
group by movies.title
order by avg desc;




-- Create table : 
create table star_wars as (
		select movies.title, avg(ratings.rating) from ratings
		full join movies
		on ratings.movieid = movies.movieid
		where (movies.title like '%Star Wars%') or (movies.title like 'Star Wars%')
		group by movies.title
		order by avg desc
);

select * from star_wars;





-- What movie was the most popular over the year 2002, 2006, 2001, 2007? (most count of ratings)
select * from movies_years;			-- displaying he count of movies in years

-- Most rated movies in 2002
select  movies.year, movies.title, round(avg(ratings.rating),2), count(ratings.movieid) from movies
full join ratings
		on movies.movieid = ratings.movieid
		group by movies.title, movies.year
		having (movies.year=2002)
		order by count desc;


-- Best rated movies in 2002
select  movies.year, movies.title, round(avg(ratings.rating),2), count(ratings.movieid) from movies
full join ratings
		on movies.movieid = ratings.movieid
		group by movies.title, movies.year
		having (movies.year=2002) and (count(ratings.movieid)>=100)
		order by round desc;
	
	
-- 2006
select  movies.year, movies.title, count(ratings.movieid) from movies
full join ratings
		on movies.movieid = ratings.movieid
		group by movies.title, movies.year
		having (movies.year=2006)
		order by count desc;

-- 2001
select  movies.year, movies.title, count(ratings.movieid) from movies
full join ratings
		on movies.movieid = ratings.movieid
		group by movies.title, movies.year
		having (movies.year=2001)
		order by count desc;


-- 2007
select  movies.year, movies.title, count(ratings.movieid) from movies
full join ratings
		on movies.movieid = ratings.movieid
		group by movies.title, movies.year
		having (movies.year=2007)
		order by count desc;
	
	
select * from ratings;			-- making use of the converted date_time column


-- Comparing the year of release favourites and the year of rating movies
select  movies.title, count(ratings.movieid), movies.year from movies
full join ratings
		on movies.movieid = ratings.movieid
		where ratings.date_time BETWEEN '2002-01-01 00:00:00'::timestamp AND '2002-12-31 23:59:59'::timestamp
		group by movies.title, movies.year 
		order by count desc;

	
	
-- Star wars come back after 1983
-- Star Wars: The Phantom Menace (1999)
-- realease of : Star Wars: Attack of the Clones (2002)


select  movies.title, count(ratings.movieid), round(avg (ratings.rating),2), movies.year from movies
full join ratings
		on movies.movieid = ratings.movieid
		where ratings.date_time BETWEEN '1999-01-01 00:00:00'::timestamp AND '1999-12-31 23:59:59'::timestamp
		group by movies.title, movies.year 
		having (movies.title like '%Star Wars%') or (movies.title like '%Star Wars') or (movies.title like 'Star Wars')
		order by count desc;


-- Star wars come back after 2005
-- Star Wars: The Force Awakens (2015)
-- Star Wars: The Last Jedi (2017)
	

-- 2015	
select  movies.title, count(ratings.movieid), round(avg (ratings.rating),2), movies.year from movies
full join ratings
		on movies.movieid = ratings.movieid
		where ratings.date_time BETWEEN '2015-01-01 00:00:00'::timestamp AND '2015-12-31 23:59:59'::timestamp
		group by movies.title, movies.year 
		having (movies.title like '%Star Wars%') or (movies.title like '%Star Wars') or (movies.title like 'Star Wars')
		order by count desc;
	
-- 2017	
select  movies.title, count(ratings.movieid), round(avg (ratings.rating),2),movies.year from movies
full join ratings
		on movies.movieid = ratings.movieid
		where ratings.date_time BETWEEN '2017-01-01 00:00:00'::timestamp AND '2017-12-31 23:59:59'::timestamp
		group by movies.title, movies.year 
		having (movies.title like '%Star Wars%') or (movies.title like '%Star Wars') or (movies.title like 'Star Wars')
		order by count desc;


	
	
	

	
-- Title : Matrix
select movies.title, count(ratings.movieid), round(avg (ratings.rating),2), movies.year from ratings
full join movies
on ratings.movieid = movies.movieid
full join tags
on ratings.movieid = tags.movieid
where (movies.title ilike '%Matrix%')  		-- ilike
group by movies.title, movies.year
having count(ratings.movieid)>=50
order by round desc
limit 10;

