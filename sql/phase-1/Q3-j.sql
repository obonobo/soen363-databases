1.
--REMEMBER TO REPLACE  
CREATE VIEW co_actors AS
SELECT DISTINCT name
FROM actors
WHERE mid IN(SELECT mid FROM actors WHERE name = 'Annette Nicole')
AND name <> 'Annette Nicole'


SELECT COUNT(1)
FROM co_actors
--179

2.
create VIEW all_combinations AS
SELECT c.name, m.mid
FROM co_actors c, movies m
WHERE mid IN(SELECT mid FROM actors WHERE name = 'Annette Nicole')

SELECT COUNT(1)
FROM all_combinations
--537

