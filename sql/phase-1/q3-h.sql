-------------------------------------------------------------------------------
--                                  3-h                                      --
-------------------------------------------------------------------------------
-- NEEDS LOADING

-- (i)

-- High rating view:
CREATE VIEW high_ratings AS
SELECT DISTINCT name
FROM actors JOIN movies
ON actors.mid = movies.mid
WHERE rating >= 4;

-- low rating view:
CREATE VIEW low_ratings AS
SELECT DISTINCT name
FROM actors JOIN movies
ON actors.mid = movies.mid
WHERE rating < 4;

-- Count number of rows for high ratings
SELECT COUNT(*)
AS numbers_of_rows
FROM high_ratings;

-- Count number of rows for low rating
SELECT COUNT(*)
AS numbers_of_rows
FROM low_ratings;

-- (ii) No flops

(SELECT * FROM high_ratings) EXCEPT (SELECT * FROM low_ratings);

-- (iii)
SELECT name, COUNT(mid)
FROM actors WHERE name
IN ((SELECT * FROM high_ratings) EXCEPT (SELECT * FROM low_ratings))
GROUP BY name
ORDER BY count DESC;
