-------------------------------------------------------------------------------
--                                  3-a                                      --
-------------------------------------------------------------------------------
SELECT M.title
FROM movies M
JOIN actors A ON M.mid = A.mid
WHERE A.name = 'Daniel Craig'
ORDER BY M.title;
