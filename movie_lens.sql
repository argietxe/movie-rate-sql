/*
psql -U postgres -h 34.159.78.51 -p 5432 -d movie_lens -f movie_lens.sql
*/



DROP TABLE IF EXISTS movies, links, ratings, tags CASCADE;   
 -- drop the tables you already created at the beginning to be sure it doesn't bump into an error

CREATE TABLE movies(movieId INT primary key, 
    title VARCHAR (255), 
    genres VARCHAR(255), 
    year INT not null);
    
CREATE TABLE links(
    id SERIAL primary key,
    movieId INT REFERENCES movies(movieid), 
    imdbId INT, 
    tmdbId INT);

CREATE TABLE ratings(
    id SERIAL primary key,
    userId INT,
    movieId INT REFERENCES movies(movieid), 
    rating NUMERIC, 
    time_stamp INT,
    date_time timestamp);
    
CREATE TABLE tags(id SERIAL primary key,
    userId INT,
    movieId INT REFERENCES movies(movieid), 
    tag VARCHAR (255),
    time_stamp INT,
    date_time timestamp); -- unsigned : used with numeric data types to specify that the column can only store non-negative values

-- "Timestamps" represent seconds since midnight Coordinated Universal Time (UTC) of January 1, 1970.


\COPY movies FROM './data/movies.csv' DELIMITER ',' CSV HEADER;

\COPY links (movieId, imdbId, tmdbId)FROM './data/links.csv' DELIMITER ',' CSV HEADER;

\COPY ratings(userId, movieId, rating, time_stamp) FROM './data/ratings.csv' DELIMITER ',' CSV HEADER;

\COPY tags(userId, movieId, tag, time_stamp) FROM './data/tags.csv' DELIMITER ',' CSV HEADER;

UPDATE tags
SET date_time = to_timestamp(time_stamp);

UPDATE ratings
SET date_time = to_timestamp(time_stamp);

--SELECT to_timestamp(time_stamp) as date FROM tags;
--SELECT to_timestamp(time_stamp) as date FROM ratings;
