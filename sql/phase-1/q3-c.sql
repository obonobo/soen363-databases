-------------------------------------------------------------------------------
--                                  3-c                                      --
-------------------------------------------------------------------------------
SELECT genre
FROM (
    SELECT G.genre, COUNT(G.mid) AS movieCount
    FROM genres G
    JOIN movies M
    ON M.mid = G.mid
    GROUP BY G.genre
) AS Temp
WHERE movieCount>1000;
