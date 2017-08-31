-- 1. Change the query shown so that it displays Nobel prizes for 1950.
SELECT yr, subject, winner
FROM nobel
WHERE yr = 1950

-- 2. Show who won the 1962 prize for Literature.
SELECT winner winner_1962
FROM nobel
WHERE yr = 1962
AND subject = 'Literature'

-- 3. Show the year and subject that won 'Albert Einstein' his prize.
SELECT yr, subject
FROM nobel
WHERE winner = 'Albert Einstein'

-- 4. Give the name of the 'Peace' winners since the year 2000, including 2000.
SELECT winner winner_peace
FROM nobel
WHERE subject = 'Peace'
AND yr >= 2000

-- 5. Show all details (yr, subject, winner) of the Literature prize winners for
-- 1980 to 1989 inclusive.
SELECT *
FROM nobel
WHERE subject = 'Literature'
AND yr BETWEEN 1980 AND 1989

-- 6. Show all details of the presidential winners: ('Theodore Roosevelt',
-- 'Woodrow Wilson', 'Jed Bartlet', 'Jimmy Carter')
SELECT *
FROM nobel
WHERE winner IN ('Theodore Roosevelt', 'Woodrow Wilson', 'Jed Bartlet',
  'Jimmy Carter')

-- 7. Show the winners with first name John
SELECT winner
FROM nobel
WHERE winner LIKE 'John%'

-- 8. In which years was the Physics prize awarded but no Chemistry prize.
-- (WARNING - this question is way too hard for this level, you will need to use
-- sub queries or joins).
SELECT DISTINCT p.yr
FROM nobel p
WHERE p.subject = 'Physics'
AND p.yr NOT IN
(
  SELECT c.yr
  FROM nobel c
  WHERE c.subject = 'Chemistry'
)

--8. simple way of answeing the 8th question without using subqueries and joins.
--Show the physics winners for 1980 together with the winners for 1984.
SELECT *
FROM nobel
WHERE (subject='Physics' AND yr=1980)
OR (subject='Chemistry' AND yr=1984)

-- 9.Show the winners for 1980 excluding the chemistry and medicine.
SELECT 
*FROM nobel WHERE yr=1980 
AND 
NOT (subject='Chemistry' OR subject='Medicine')

--10. Show who won a 'Medicine' prize in an early year (before 1910, not including 1910) 
--together with winners of a 'Literature' prize in a later year
--(after 2004, including 2004).
SELECT *
FROM nobel
WHERE (yr<1910 AND subject='Medicine')
OR
(yr>=2004 AND subject='Literature')

   
        
