-------------------------------------------------------------------------------
--                                  3-j                                      --
-------------------------------------------------------------------------------
--          NEEDS LOADING

-- 1.
--REMEMBER TO REPLACE
CREATE VIEW co_actors AS
SELECT DISTINCT name
FROM actors
WHERE mid IN(SELECT mid FROM actors WHERE name = 'Annette Nicole')
AND name <> 'Annette Nicole'


SELECT COUNT(1)
FROM co_actors
--178

-- 2.
create VIEW all_combinations AS
SELECT c.name, m.mid
FROM co_actors c, movies m
WHERE mid IN(SELECT mid FROM actors WHERE name = 'Annette Nicole')

SELECT COUNT(1)
FROM all_combinations
--534

-- 3.
CREATE VIEW non_existent AS
SELECT ac.mid, ac.name
FROM all_combinations ac
LEFT JOIN (SELECT ac.mid, ac.name
FROM all_combinations ac, actors a
WHERE a.mid = ac.mid AND a.name = ac.name) z ON z.name = ac.name AND z.mid = ac.mid
WHERE z.mid is null

SELECT COUNT(1)
FROM non_existent
--239

-- 4.
SELECT ca.name
FROM co_actors ca
LEFT JOIN non_existent ne
ON ne.name = ca.name
WHERE ne.name is null

