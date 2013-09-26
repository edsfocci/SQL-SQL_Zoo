-- 1. List the films where the yr is 1962 [Show id, title]
SELECT id, title
FROM movie
WHERE yr=1962

-- 2. Give year of 'Citizen Kane'.
SELECT yr
FROM movie
WHERE title = 'Citizen Kane'

-- 3. List all of the Star Trek movies, include the id, title and yr (all of
-- these movies include the words Star Trek in the title). Order results
-- by year.
SELECT id, title, yr
FROM  movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr

-- 4. What are the titles of the films with id 11768, 11955, 21191
SELECT title
FROM movie
WHERE id IN (11768, 11955, 21191)

-- 5. What id number does the actor 'Glenn Close' have?
SELECT id
FROM actor
WHERE name = 'Glenn Close'

-- 6. What is the id of the film 'Casablanca'
SELECT id
FROM movie
WHERE title = 'Casablanca'

-- 7. Obtain the cast list for 'Casablanca'. Use the id value that you obtained
-- in the previous question.
SELECT name
FROM actor
JOIN casting ON actor.id = casting.actorid
WHERE casting.movieid = 11768

-- 8. Obtain the cast list for the film 'Alien'
SELECT actor.name
FROM actor
JOIN casting ON actor.id = casting.actorid
JOIN movie ON movie.id = casting.movieid
WHERE title = 'Alien'

-- 9. List the films in which 'Harrison Ford' has appeared
SELECT movie.title
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON actor.id = casting.actorid
WHERE name = 'Harrison Ford'

-- 10. List the films where 'Harrison Ford' has appeared - but not in the star
-- role. [Note: the ord field of casting gives the position of the actor.
-- If ord=1 then this actor is in the starring role]
SELECT movie.title
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON actor.id = casting.actorid
WHERE name = 'Harrison Ford'
AND casting.ord <> 1

-- 11. List the films together with the leading star for all 1962 films.
SELECT title, name leading_star
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON actor.id = casting.actorid
WHERE movie.yr = 1962
AND casting.ord = 1

-- 12. Which were the busiest years for 'John Travolta', show the year and the
-- number of movies he made each year for any year in which he made at least
-- 2 movies.
SELECT yr, COUNT(title) num_movies
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
WHERE name = 'John Travolta'
GROUP BY yr
HAVING COUNT(title) =
(
  SELECT MAX(c)
	FROM
  (
    SELECT yr, COUNT(title) AS c
    FROM movie
    JOIN casting ON movie.id = casting.movieid
    JOIN actor ON casting.actorid = actor.id
    WHERE name = 'John Travolta'
    GROUP BY yr
  ) AS t
)

-- 13. List the film title and the leading actor for all of the films
-- 'Julie Andrews' played in.
SELECT DISTINCT b.title, a.name leading_star
FROM
(
  SELECT movie.title, actor.name, casting.movieid
  FROM movie
  JOIN casting ON movie.id = casting.movieid
  JOIN actor ON casting.actorid = actor.id
  WHERE casting.ord = 1
) AS a
JOIN
(
  SELECT movie.title, casting.movieid
  FROM movie
  JOIN casting ON movie.id = casting.movieid
  JOIN actor ON casting.actorid = actor.id
  WHERE actor.name = 'Julie Andrews'
) AS b
ON a.movieid = b.movieid

-- 14. Obtain a list in alphabetical order of actors who've had at least 30
-- starring roles.
SELECT a.name
FROM
(
  SELECT actor.name, COUNT(casting.movieid) star_count
  FROM actor
  JOIN casting ON actor.id = casting.actorid
  WHERE casting.ord = 1
  GROUP BY actor.name
) AS a
WHERE star_count >=30
ORDER BY a.name

-- 15. List the 1978 films by order of cast list size.
SELECT movie.title, COUNT(*) cast_size
FROM movie
JOIN casting ON movie.id = casting.movieid
WHERE movie.yr = 1978
GROUP BY movie.title
ORDER BY cast_size DESC

-- 16. List all the people who have worked with 'Art Garfunkel'.
SELECT DISTINCT actor.name
FROM actor
JOIN casting ON actor.id = casting.actorid
JOIN
(
  SELECT casting.movieid
  FROM actor
  JOIN casting ON actor.id = casting.actorid
  WHERE actor.name = 'Art Garfunkel'
) AS a
ON casting.movieid = a.movieid
WHERE actor.name <> 'Art Garfunkel'
