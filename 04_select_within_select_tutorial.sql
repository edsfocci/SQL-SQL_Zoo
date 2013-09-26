-- 1. List each country name where the population is larger than 'Russia'.
SELECT name country
FROM world
WHERE population >
(
  SELECT population FROM world
  WHERE name='Russia'
)

-- 2. List the name and continent of countries in the continents containing
-- 'Belize', 'Belgium'.
SELECT a.name country, a.continent
FROM world a
WHERE a.continent IN
(
  SELECT b.continent
  FROM world b
  WHERE b.name IN ('Belize', 'Belgium')
)

-- 3. Show the countries in Europe with a per capita GDP greater than
-- 'United Kingdom'.
SELECT a.name country
FROM world a
WHERE a.continent = 'Europe'
AND a.gdp/a.population >
(
  SELECT b.gdp/b.population
  FROM world b
  WHERE b.name = 'United Kingdom'
)

-- 4. Which country has a population that is more than Canada but less than
-- Poland? Show the name and the population.
SELECT a.name country, a.population
FROM world a
WHERE a.population >
(
  SELECT b.population
  FROM world b
  WHERE b.name = 'Canada'
)
AND a.population <
(
  SELECT c.population
  FROM world c
  WHERE c.name = 'Poland'
)

-- 5. Which countries have a GDP greater than any country in Europe? [Give the
-- name only.]
SELECT a.name country
FROM world a
WHERE a.gdp > ALL
(
  SELECT b.gdp
  FROM world b
  WHERE b.continent = 'Europe'
)

-- 6. Find the largest country (by area) in each continent, show the continent,
-- the name and the area:
SELECT continent, name country, area
FROM world x
WHERE area >= ALL
(
  SELECT area FROM world y
  WHERE y.continent=x.continent
  AND area>0
)

-- 7. Find each country that belongs to a continent where all populations are
-- less than 25000000. Show name, continent and population.
SELECT a.name country, a.continent, a.population
FROM world a
WHERE 25000000 > ALL
(
  SELECT b.population
  FROM world b
  WHERE a.continent = b.continent
  AND b.population > 0
)

-- 8. Some countries have populations more than three times that of any of their
-- neighbours (in the same continent). Give the countries and continents.
SELECT a.name country, a.continent
FROM world a
WHERE a.population > ALL
(
  SELECT b.population*3
  FROM world b
  WHERE a.continent = b.continent
  AND a.name <> b.name
)
