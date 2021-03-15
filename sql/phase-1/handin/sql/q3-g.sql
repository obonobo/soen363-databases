-------------------------------------------------------------------------------
--                                  3-g                                      --
-------------------------------------------------------------------------------

SELECT m.year, m.title, m.rating
FROM movies m, (SELECT m.year, MIN(rating) AS min_rating, MAX(rating) AS max_rating
                FROM movies m
                WHERE m.year <=2011
                AND m.year >=2005
                AND num_ratings <> 0
                GROUP BY m.year) mm
WHERE m.year = mm.year
AND (m.rating = mm.min_rating
OR m.rating = mm.max_rating)
GROUP BY m.year, m.title, m.rating
ORDER BY m.year, m.rating, m.title;
