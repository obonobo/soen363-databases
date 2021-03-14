-------------------------------------------------------------------------------
--                                  3-g                                      --
-------------------------------------------------------------------------------

SELECT m.year, m.title, m.rating
FROM movies m, (SELECT m.year, MIN(rating) AS minrating, Max(rating) AS maxrating
                FROM movies m
                WHERE m.year <=2011
                AND m.year >=2005
                AND num_rating <> 0
                GROUP BY m.year) mm
WHERE m.year = mm.year
AND (m.rating = mm.minrating
OR m.rating = mm.maxrating)
GROUP BY m.year, m.title, m.rating
ORDER BY m.year, m.rating, m.title;
