/*q3i*/
SELECT name
FROM (
        SELECT A.name,MAX(M.year)-MIN(M.year) AS diff 
        FROM movies M
        JOIN actors A
        ON M.mid = A.mid                --Joins two tables based on ID
        GROUP BY A.name                    -- instructs to find diff for every exisitng A.name
        HAVING A.name LIKE '%_%'
        ORDER BY diff DESC
        LIMIT 1
) AS TEMP;