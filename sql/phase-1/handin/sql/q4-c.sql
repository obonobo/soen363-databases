
--- Creating the view
CREATE MATERIALIZED VIEW distinct_co_actors_materialized AS
SELECT a.name, COUNT(DISTINCT(a2.name)) AS num_co_actors
FROM actors AS a
JOIN actors AS a2 ON TRUE
JOIN movies AS m  ON a.mid = m.mid
JOIN movies AS m2 ON a2.mid = m2.mid AND m.mid = m2.mid AND a.name != a2.name
GROUP BY a.name;

--- Querying the view for the actors with the highest number of co-actors
SELECT * FROM distinct_co_actors
WHERE num_co_actors = (
    SELECT MAX(num_co_actors)
    FROM distinct_co_actors)
ORDER BY name;