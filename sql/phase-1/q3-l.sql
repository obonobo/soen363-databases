/*Number Of Actors*/
CREATE VIEW no_of_actors AS
SELECT M.title AS title, COUNT(A.mid) as actorsCount
FROM movies M
JOIN actors A
ON M.mid = A.mid                
GROUP BY M.title;

-- DROP VIEW no_of_actors;
-- DROP VIEW no_of_common_actors;

/*Common Actors*/
-- SELECT M1.title, M2.title, A1.name
-- FROM movies M1 ,movies M2, actors A1,actors A2
-- WHERE m1.mid = a1.mid and m2.mid =a2.mid and a1.name=a2.name and M1.title != M2.title;

/*No Of Common Actors*/
CREATE VIEW no_of_common_actors AS
SELECT M1.title AS T1 , M2.title AS T2 , count(A1.name) AS commonActor
FROM movies M1 ,movies M2, actors A1,actors A2
WHERE m1.mid = a1.mid and m2.mid =a2.mid and a1.name=a2.name and M1.title != M2.title
GROUP BY M1.title , M2.title;

/* Common actor fraction*/
SELECT M1.title , M2.title , (N2.commonActor/N1.actorsCount) AS diff
FROM movies M1 , movies M2 ,no_of_actors N1, no_of_common_actors N2
WHERE M1.title = N1.title AND M1.title = N2.T1 AND M2.title=N2.T2 AND (N2.commonActor/N1.actorsCount)!=0 AND M1.title != M2.title; ;

/*Returns actor list*/
-- SELECT M.title, A.name
-- FROM movies M, actors A
-- WHERE A.mid = M.mid;

/*Number Of Tags*/
CREATE VIEW no_of_tags AS
SELECT M.title, COUNT(TT.tag) AS tagCount
FROM movies M, tags T, tag_names TT
WHERE T.tid = TT.tid AND T.mid = M.mid               
GROUP BY M.title;

/*No Of Common Tags*/
CREATE VIEW no_of_common_tags AS
SELECT M1.title, M2.title, count(TT1.tag)
FROM movies M1 ,movies M2,  tags T1, tags T2, tag_names TT1, tag_names TT2
WHERE M1.mid = T1.mid and M2.mid = T2.mid and TT1.tag = TT2.tag and TT1.tid = T1.tid and TT2.tid = T2.tid and M1.title != M2.title
GROUP BY M1.title , M2.title;

/*Number of Genres*/
CREATE VIEW no_of_genres AS
SELECT M.title, COUNT(G.genre) as genreCount
FROM movies M
JOIN Genres G
ON M.mid = G.mid                
GROUP BY M.title;

/*No Of Common Genres*/
CREATE VIEW no_of_common_genres AS
SELECT M1.title, M2.title, count(G1.genre) 
FROM movies M1 ,movies M2, Genres G1, Genres G2
WHERE m1.mid = G1.mid  and m2.mid = G2.mid and G1.genre = G2.genre and M1.title != M2.title
GROUP BY M1.title , M2.title;

/*Normalized year difference*/
CREATE VIEW year_diff AS
SELECT M1.title, M2.title, ABS(M1.year-M2.year) AS diff
FROM movies M1 ,movies M2
WHERE M1.title != M2.title

/*Normalized rating difference*/
CREATE VIEW rating_diff AS
SELECT M1.title, M2.title, ABS(M1.rating-M2.rating) AS diff
FROM movies M1 ,movies M2
WHERE M1.title != M2.title