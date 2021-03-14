-------------------------------------------------------------------------------
--                                  3-e                                      --
-------------------------------------------------------------------------------
SELECT title FROM movies AS m
WHERE EXISTS (
    SELECT mid FROM tags
    JOIN tag_names ON tag_names.tid = tags.tid
    WHERE mid = m.mid
    AND LOWER(tag) LIKE '%good%')
AND EXISTS (
    SELECT mid FROM tags
    JOIN tag_names ON tag_names.tid = tags.tid
    WHERE mid = m.mid
    AND LOWER(tag) LIKE '%bad%');
