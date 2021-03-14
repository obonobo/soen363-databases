-------------------------------------------------------------------------------
--                                  3-m                                      --
-------------------------------------------------------------------------------

---- LIST OF TABLE WITH DUPLICATES:
--       - Movies
--       - Actors (if we count the duplicate movie MIDs)
--       - Genres (if we count the duplicate movie MIDs)
--       - Tags (if we count the duplicate movie MIDs)



                            --==== MOVIES ====--
-- Find duplicates in movies table
SELECT title, year, rating, num_ratings, COUNT(mid)
FROM movies
GROUP BY title, year, rating, num_ratings
HAVING COUNT(mid) > 1
ORDER BY title;

-- Remove duplicates from the movies table
SELECT MIN(mid) AS mid, title, year, rating, num_ratings
FROM movies
GROUP BY title, year, rating, num_ratings
ORDER BY title;

CREATE VIEW movies_no_duplicates AS
    SELECT MIN(mid) AS mid, title, year, rating, num_ratings
    FROM movies
    GROUP BY title, year, rating, num_ratings;


                            --==== ACTORS ====--
-- We might want to remove the duplicate movie records from the actors table
-- If there is a pair of duplicate movie records and the actor has an associated
-- record for each movie, then we may want to remove those duplicate movies from
-- both the movies table and the actors table
--
-- This would be easier to start off with doing the no-duplicate movie view and
-- then simply doing a join with this view and actors table to create a new view

-- Display all duplicates from actors
SELECT name, cast_position, title AS movie_title, temp.count AS count FROM (
    SELECT name, cast_position, title,
           year, rating, num_ratings,
           COUNT(movies.mid)
    FROM actors
    JOIN movies ON actors.mid = movies.mid
    GROUP BY name, cast_position, title, year, rating, num_ratings
    HAVING COUNT(movies.mid) > 1) AS temp
ORDER BY name, cast_position;

-- Actors table, no duplicates
CREATE VIEW actors_no_duplicates AS
    SELECT actors.* FROM actors
    JOIN (
        SELECT MIN(mid) AS mid, title, year, rating, num_ratings
        FROM movies
        GROUP BY title, year, rating, num_ratings
    ) AS movies_no_dup ON movies_no_dup.mid = actors.mid;


                            --==== GENRES ====--
-- Display all duplicate genres
SELECT genre, title AS movie_title, temp.count AS count FROM (
    SELECT genre, title, year, rating,
           num_ratings, COUNT(movies.mid)
    FROM genres
    JOIN movies ON genres.mid = movies.mid
    GROUP BY genre, title, year, rating, num_ratings
    HAVING COUNT(movies.mid) > 1)
AS temp
ORDER BY genre, movie_title;

-- Genres table, no duplicates
CREATE VIEW genres_no_duplicates AS
    SELECT genres.* FROM genres
    JOIN (
        SELECT MIN(mid) AS mid, title, year, rating, num_ratings
        FROM movies
        GROUP BY title, year, rating, num_ratings
    ) AS movies_no_dup ON movies_no_dup.mid = genres.mid
    ORDER BY genre, mid;


                          --==== TAG_NAMES ====--
-- Display all duplicate tag_names
SELECT tag, COUNT(tid)
FROM tag_names
GROUP BY tag
HAVING COUNT(tid) > 1
ORDER BY tag;
--- => This query outputs 0 rows, thus there are no duplicates tags

-- REDUNDANT: tag_names table, no duplicates. (The tag_names table already has
--            no duplicate tags)
CREATE VIEW tag_names_no_duplicates AS
    SELECT MIN(tid) AS tid, tag
    FROM tag_names
    GROUP BY tag;

-- Show whether the view and the no_dup view are equivalent
SELECT normal_count, no_duplicate_count,
       (normal_count = no_duplicate_count) AS equal
FROM (
    SELECT COUNT(*) AS normal_count
    FROM tag_names) AS normal
JOIN (
    SELECT COUNT(*) AS no_duplicate_count
    FROM tag_names_no_duplicates) as no_dup ON TRUE;


                          --==== TAGS ====--
-- `Tags`, in contrast to `Tag_names`, *does* have duplicates if we count the
-- duplicated movie IDs (movies.mid). We can give it the same treatment as the
-- actors and genres tables, where we removed the entries that correspond to
-- duplicated movies by joining the table with `movies` and using
-- `COUNT` + `GROUP BY` to eliminate the duplicated rows

-- Display all duplicate movie tags
SELECT tid, tag, title AS movie_title, temp.count AS count FROM (
    SELECT tags.tid, tag, title, year, rating,
           num_ratings, COUNT(movies.mid)
    FROM tags
    JOIN tag_names ON tags.tid = tag_names.tid
    JOIN movies ON tags.mid = movies.mid
    GROUP BY tags.tid, tag, title, year, rating, num_ratings
    HAVING COUNT(movies.mid) > 1)
AS temp
ORDER BY tid, tag, movie_title;

-- Tags table, no duplicates
CREATE VIEW tags_no_duplicates AS
    SELECT tags.* FROM tags
    JOIN (
        SELECT MIN(mid) AS mid, title, year, rating, num_ratings
        FROM movies
        GROUP BY title, year, rating, num_ratings
    ) AS movies_no_dup ON movies_no_dup.mid = tags.mid
    ORDER BY tid, mid;

