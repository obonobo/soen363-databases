-------------------------------------------------------------------------------
--                                  3-b                                      --
-------------------------------------------------------------------------------
SELECT A.name
FROM actors A
JOIN movies M ON M.mid = A.mid
WHERE M.title = 'The Dark Knight'
ORDER BY A.name;
