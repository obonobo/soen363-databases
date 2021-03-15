-------------------------------------------------------------------------------
--                                  3-f
-------------------------------------------------------------------------------

--- (i)
SELECT * FROM movies
WHERE num_ratings = (
    SELECT MAX(num_ratings)
    FROM movies);


--- (ii)
SELECT * FROM movies
WHERE rating = (
    SELECT MAX(rating) FROM movies)
ORDER BY mid;


--- (iii)
-- Q: Are the movie(s) with highest NUMBER of ratings the same as movies with
--    highest rating?
--
-- A: No, they are not. Below is a query that shows this fact. What we are doing
--    is taking the intersection of the two above queries. i.e. we are finding
--    which movies are both highest rated and most rated. There are none and the
--    query returns the empty set.

---- Using set operator INTERSECT:
(
    SELECT * FROM movies
    WHERE num_ratings = (
        SELECT MAX(num_ratings)
        FROM movies)
) INTERSECT (
    SELECT * FROM movies
    WHERE rating = (
        SELECT MAX(rating)
        FROM movies)
);

---- Without set operators:
SELECT * FROM movies
WHERE num_ratings = (SELECT MAX(num_ratings) FROM movies)
AND   rating      = (SELECT MAX(rating) FROM movies);


--- (iv)
SELECT * FROM movies
WHERE rating = (
    SELECT MIN(rating)
    FROM movies)
ORDER BY mid;


--- (v)
---- Using set operator INTERSECT:
(
    SELECT * FROM movies
    WHERE num_ratings = (
        SELECT MAX(num_ratings)
        FROM movies)
) INTERSECT (
    SELECT * FROM movies
    WHERE rating = (
        SELECT MIN(rating)
        FROM movies)
);

---- Without set operators:
SELECT * FROM movies
WHERE num_ratings = (SELECT MAX(num_ratings) FROM movies)
AND   rating      = (SELECT MIN(rating) FROM movies);


--- (vi)
-- Q: Is our hypothesis correct?
-- A: No, it is not correct; movies with the highest (or lowest) number of
--    ratings are neither the highest rated, nor the lowest rated.
