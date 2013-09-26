-- 1. Observe the result of running a simple SQL command.
SELECT name country, continent, population
FROM world

-- 2. Show the name for the countries that have a population of at least 200
-- million.
SELECT name country
FROM world
WHERE population>200000000

-- 3. Give the name and the per capita GDP for those countries with a
-- population of at least 200 million.
SELECT name country, gdp/population per_capita_gdp
FROM world
WHERE population > 200E6

-- 4. Show the (name) and (population) in millions for the countries of
-- 'South America' Divide the population by 1000000 to get population in
-- millions.
SELECT name country, population/1000000 pop_millions
FROM world
WHERE continent = 'South America'

-- 5. Show the (name) and (population) for 'France', 'Germany', 'Italy'
SELECT name country, population
FROM world
WHERE name IN ('France', 'Germany', 'Italy')

-- 6. Identify the countries which have names including the word 'United'
SELECT name country
FROM world
WHERE name LIKE '%United%'
