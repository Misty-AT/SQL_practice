USE movielens;
-- List the titles and release dates of movies released between 1983-1993 in reverse chronological order.
SELECT title, YEAR(release_date) FROM movies
WHERE YEAR(release_date) BETWEEN 1983 AND 1993; #auto display as descending

-- Without using LIMIT, list the titles of the movies with the lowest average rating.
#join movies and ratings
SELECT m.title, AVG(r.rating) AS AverageRating
FROM movies m
JOIN ratings r ON m.id=r.movie_id
GROUP BY (m.title) 
ORDER BY AverageRating ASC;

-- List the unique records for Sci-Fi movies where male 24-year-old students have given 5-star ratings.
#view males, 24, 5* reviews #improve: merge views?
CREATE VIEW m245
AS
	SELECT u.id, r.movie_id
    FROM movielens.users u
    JOIN movielens.ratings r ON u.id=r.user_id
    WHERE u.age = "24" AND u.gender = "M" AND r.rating = "5" AND occupation_id = "19";

#view movies, sci-fi
CREATE VIEW scifi_movies
AS
	SELECT  g.name, gm.movie_id, m.title
    FROM movielens.genres g
    JOIN movielens.genres_movies gm ON g.id=gm.genre_id
    JOIN movielens.movies m ON m.id=gm.movie_id
    WHERE g.id = "15";
    
#creates list of movies with 5* reviews from 24yo male students
SELECT s.title
FROM movielens.scifi_movies s
JOIN movielens.m245 m ON s.movie_id=m.movie_id;

-- List the unique titles of each of the movies released on the most popular release day.

CREATE VIEW Release_Numbers
AS
SELECT title, release_date, COUNT(release_date) AS 'No of Releases'
FROM movielens.movies
GROUP BY release_date
ORDER BY Release_Date DESC;

#join release_numbers and movies by date, use MAX(no of releases)?


-- Find the total number of movies in each genre; list the results in ascending numeric order.