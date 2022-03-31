USE sakila;

-- List all actors.
SELECT * 
FROM actor;

-- Find the surname of the actor with the forename 'John'.
SELECT * 
FROM actor
WHERE actor.first_name = "John";

-- Find all actors with surname 'Neeson'.
SELECT * 
FROM actor
WHERE actor.last_name = "Neeson";

-- Find all actors with ID numbers divisible by 10.
SELECT * 
FROM actor
WHERE actor.actor_id%10 = 0;

-- What is the description of the movie with an ID of 100?
SELECT title, description 
FROM sakila.film
WHERE film.film_id = "100";

-- Find every R-rated movie.
SELECT film_id, title
FROM sakila.film
WHERE film.rating = "R";

-- Find every non-R-rated movie.
SELECT film_id, title
FROM sakila.film
WHERE film.rating != "R";

-- Find the ten shortest movies.
SELECT * 
FROM sakila.film
ORDER BY film.length LIMIT 10;

-- Find the movies with the longest runtime, without using LIMIT.
SELECT * 
FROM sakila.film
GROUP BY film.length
ORDER BY film.length DESC;

-- Find all movies that have deleted scenes.
SELECT *
FROM sakila.film
WHERE special_features = "Deleted Scenes";

-- Using HAVING, reverse-alphabetically list the last names that are not repeated.
SELECT last_name, COUNT(last_name)
FROM sakila.actor
GROUP BY last_name
HAVING COUNT(last_name)=1
ORDER BY last_name DESC;

-- Using HAVING, list the last names that appear more than once, from highest to lowest frequency.
SELECT last_name, COUNT(last_name)
FROM sakila.actor
GROUP BY actor.last_name
HAVING COUNT(last_name)>1
ORDER BY last_name ASC;

-- Which actor has appeared in the most films?
SELECT a.actor_id, COUNT(f.actor_id) AS number_of_films
FROM sakila.actor a
JOIN sakila.film_actor f ON f.actor_id=a.actor_id
GROUP BY f.actor_id
ORDER BY number_of_films DESC LIMIT 1;

-- When is 'Academy Dinosaur' due?
SELECT title, release_year
FROM sakila.film
WHERE title = "Academy Dinosaur";

-- What is the average runtime of all films?
SELECT AVG(length) AS average_length
FROM sakila.film;

-- List the average runtime for every film category.
SELECT cat.name, AVG(length)
FROM sakila.film_category fc
JOIN sakila.category cat ON fc.category_id=cat.category_id
JOIN sakila.film f ON f.film_id=fc.film_id
GROUP BY cat.name;

-- List all movies featuring a robot.
SELECT title
FROM sakila.film
WHERE film.description LIKE '%robot%' OR film.description LIKE '%Robot%';

-- How many movies were released in 2010?
SELECT COUNT(film.release_year) = Released_2010
FROM sakila.film
WHERE COUNT(film.release_year) = "2010";

-- Find the titles of all the horror movies.
CREATE VIEW films_with_categories
AS
SELECT f.title, c.name
FROM sakila.film_category fc
JOIN sakila.category c ON c.category_id=fc.category_id
JOIN sakila.film f ON fc.film_id=f.film_id;

SELECT title
FROM films_with_categories
WHERE name = "Horror";

-- List the full name of the staff member with the ID of 2.
SELECT *
FROM sakila.staff
WHERE staff_id = "2";
-- List all the movies that Fred Costner has appeared in.
CREATE VIEW actors_with_films
AS
SELECT a.first_name, a.last_name, f.title
FROM sakila.film_actor fa
JOIN sakila.film f ON f.film_id=fa.film_id
JOIN sakila.actor a ON a.actor_id=fa.actor_id
ORDER BY f.title;

SELECT title
FROM actors_with_films
WHERE first_name = "Fred" AND last_name = "Costner";

-- How many distinct countries are there?
SELECT COUNT(DISTINCT country) AS country_number
FROM sakila.country;

-- List the name of every language in reverse-alphabetical order.
SELECT name
FROM language
ORDER BY name DESC;

-- List the full names of every actor whose surname ends with '-son' in alphabetical order by their forename.
SELECT first_name, last_name 
FROM sakila.actor
WHERE last_name LIKE "%son"
ORDER BY first_name;

-- Which category contains the most films?
CREATE VIEW films_per_category
AS
SELECT cat.name, COUNT(name) AS number_of_films
FROM sakila.film_category fc
JOIN sakila.category cat ON fc.category_id=cat.category_id
JOIN sakila.film f ON f.film_id=fc.film_id
GROUP BY cat.name;

SELECT name, MAX(number_of_films)
FROM films_per_category;