USE world;

-- Using COUNT, get the number of cities in the USA.
SELECT COUNT(Name) AS Number_of_cities
FROM world.city;

-- Find out the population and life expectancy for people in Argentina
SELECT Name, Population, LifeExpectancy
FROM world.country
WHERE Name = "Argentina";

-- Using IS NOT NULL, ORDER BY, and LIMIT, which country has the highest life expectancy?
SELECT Name, LifeExpectancy
FROM world.country
WHERE LifeExpectancy IS NOT NULL
ORDER BY LifeExpectancy DESC LIMIT 1;

-- Using JOIN ... ON, find the capital city of Spain.
SELECT country.Name, city.name AS CapitalCity
FROM world.country 
JOIN world.city ON city.ID=country.Capital
WHERE country.Name = "Spain";

-- Using JOIN ... ON, list all the languages spoken in the Southeast Asia region.
SELECT cl.Language
FROM world.countrylanguage cl
JOIN world.country c ON c.Code=cl.CountryCode
WHERE Region = "Southeast Asia";

-- Using a single query, list 25 cities around the world that start with the letter F.
SELECT Name
FROM world.city
WHERE Name LIKE "F%"
ORDER BY Name LIMIT 25;

-- Using COUNT and JOIN ... ON, get the number of cities in China.
SELECT COUNT(city.Name)
FROM world.city
JOIN world.country ON city.CountryCode=country.code
WHERE country.Name = "China";

-- Using IS NOT NULL, ORDER BY, and LIMIT, which country has the lowest population? Discard non-zero populations.
SELECT Name, Population
FROM world.country
WHERE Population IS NOT NULL
ORDER BY Population ASC LIMIT 1;

-- Using aggregate functions, return the number of countries the database contains.
SELECT COUNT(Name) AS number_of_countries
FROM world.country;

-- What are the top ten largest countries by area?
SELECT Name
FROM world.country
ORDER BY SurfaceArea DESC LIMIT 10;

-- List the five largest cities by population in Japan.
SELECT Name 
FROM world.city
ORDER BY Population Limit 5;

-- List the names and country codes of every country with Elizabeth II as its Head of State. You will need to fix the mistake first!
UPDATE world.country
SET
	country.HeadOfState = 'Elizabeth II'
WHERE
	country.HeadOfState = 'Elisabeth II';

SELECT Name, Code
FROM world.country
WHERE HeadOfState="Elizabeth II";

-- List the top ten countries with the smallest population-to-area ratio. Discard any countries with a ratio of 0.
SELECT Name, Population, SurfaceArea, Population%SurfaceArea AS Population_to_Area
FROM world.country
WHERE Population%SurfaceArea > 0
ORDER BY Population_to_Area LIMIT 10;

-- List every unique world language.
SELECT DISTINCT Language
FROM world.countrylanguage
ORDER BY Language;

-- List the names and GNP of the world's top 10 richest countries.
SELECT Name, GNP
FROM world.country
ORDER BY GNP DESC LIMIT 10;

-- List the names of, and number of languages spoken by, the top ten most multilingual countries.
SELECT c.Name, COUNT(cl.Language) AS Languages_spoken
FROM world.countrylanguage cl
JOIN world.country c ON cl.CountryCode=c.Code
GROUP BY c.Name
ORDER BY COUNT(cl.Language) DESC LIMIT 10;

-- List every country where over 50% of its population can speak German.
SELECT c.Name
FROM world.country c
JOIN world.countrylanguage cl ON c.Code=cl.CountryCode
WHERE cl.Language = "German" AND cl.Percentage > 50;

-- Which country has the worst life expectancy? Discard zero or null values.
SELECT Name
FROM world.country
WHERE LifeExpectancy !=0 AND LifeExpectancy IS NOT NULL
ORDER BY LifeExpectancy ASC LIMIT 1;

-- List the top three most common government forms.
SELECT GovernmentForm, COUNT(GovernmentForm) AS number
FROM world.country
GROUP BY GovernmentForm
ORDER BY COUNT(GovernmentForm) DESC LIMIT 3;

-- How many countries have gained independence since records began?
SELECT COUNT(IndepYear) AS Countries
FROM world.country
WHERE IndepYear IS NOT NULL;