/* q3a */
SELECT M.title
FROM movies M
JOIN actors A ON M.mid = A.mid
WHERE A.name = 'Daniel Craig'
ORDER BY M.title;

/* q3b */
SELECT A.name
FROM actors A
JOIN movies M ON M.mid = A.mid
WHERE M.title = 'The Dark Knight'
ORDER BY A.name;

/* q3c */
SELECT genre
FROM (
    SELECT G.genre, COUNT(G.mid) AS movieCount
    FROM genres G
    JOIN movies M
    ON M.mid = G.mid
    GROUP BY G.genre
) AS Temp
WHERE movieCount>1000;

/* q3d */
SELECT M.title, M.year , M.rating
FROM movies M
ORDER BY M.year ASC, M.rating DESC;

/* q3i */
SELECT name FROM (
    SELECT A.name, MAX(M.year) - MIN(M.year) AS diff
    FROM movies M
    JOIN actors A ON M.mid = A.mid
    GROUP BY A.name
    HAVING A.name LIKE '%_%'
    ORDER BY diff DESC
    LIMIT 1
) AS TEMP;

