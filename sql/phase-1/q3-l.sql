-- NEEDS LOADING

/*Number Of Actors*/
CREATE VIEW no_of_actors AS
SELECT M.mid AS mid, COUNT(A.mid) as actorsCount
FROM movies M
JOIN actors A
ON M.mid = A.mid
GROUP BY M.mid;

/*No Of Common Actors*/
CREATE VIEW no_of_common_actors AS
SELECT M1.mid AS mid1 , M2.mid AS mid2 , count(A1.name) AS commonActor
FROM movies M1 ,movies M2, actors A1,actors A2
WHERE m1.mid = a1.mid and m2.mid =a2.mid and a1.name=a2.name and M1.mid != M2.mid
GROUP BY M1.mid , M2.mid;

/* Common actor fraction*/
CREATE VIEW fraction_of_common_actors AS
SELECT M1.mid as mid1, M2.mid as mid2, (CAST(N2.commonActor AS float)/CAST(N1.actorsCount AS float)) AS diff
FROM movies M1 , movies M2 ,no_of_actors N1, no_of_common_actors N2
WHERE M1.mid = N1.mid AND M1.mid = N2.mid1 AND M2.mid=N2.mid2 AND M1.mid != M2.mid;

/*Number Of Tags*/
CREATE VIEW no_of_tags AS
SELECT M.mid , COUNT(TT.tag) AS tagCount
FROM movies M, tags T, tag_names TT
WHERE T.tid = TT.tid AND T.mid = M.mid
GROUP BY M.mid;

/*No Of Common Tags*/
CREATE VIEW no_of_common_tags AS
SELECT M1.mid as mid1, M2.mid as mid2 , count(TT1.tag) AS commonTag
FROM movies M1 ,movies M2,  tags T1, tags T2, tag_names TT1, tag_names TT2
WHERE M1.mid = T1.mid and M2.mid = T2.mid and TT1.tag = TT2.tag and TT1.tid = T1.tid and TT2.tid = T2.tid and M1.mid != M2.mid
GROUP BY M1.mid , M2.mid;


/* Common tag fraction*/
CREATE VIEW fraction_of_common_tags AS
SELECT M1.mid as mid1, M2.mid as mid2, (CAST(N2. commonTag AS float)/CAST(N1.tagCount AS float)) AS diff
FROM movies M1 , movies M2 ,no_of_tags N1, no_of_common_tags N2
WHERE M1.mid = N1.mid AND M1.mid = N2.mid1 AND M2.mid=N2.mid2 AND M1.mid != M2.mid;

/*Number of Genres*/
CREATE VIEW no_of_genres AS
SELECT M.mid AS mid , COUNT(G.genre) as genreCount
FROM movies M
JOIN Genres G
ON M.mid = G.mid
GROUP BY M.mid;

/*No Of Common Genres*/
CREATE VIEW no_of_common_genres AS
SELECT M1.mid AS mid1 , M2.mid AS mid2 , count(G1.genre) AS commonGenre
FROM movies M1 ,movies M2, Genres G1, Genres G2
WHERE m1.mid = G1.mid  and m2.mid = G2.mid and G1.genre = G2.genre and M1.mid!= M2.mid
GROUP BY M1.mid , M2.mid;

/* Common Genre fraction*/
CREATE VIEW fraction_of_common_genres AS
SELECT M1.mid as mid1, M2.mid as mid2, (CAST(N2.commonGenre AS float)/CAST(N1.genreCount AS float)) AS diff
FROM movies M1 , movies M2 ,no_of_genres N1, no_of_common_genres N2
WHERE M1.mid = N1.mid AND M1.mid = N2.mid1 AND M2.mid=N2.mid2 AND M1.mid != M2.mid;

/*Normalized year difference*/
CREATE VIEW year_diff AS
SELECT M1.mid AS mid1, M2.mid AS mid2,1-(ABS(CAST( (M1.year-M2.year)As float))/CAST( (M1.year)As float)) AS diff
FROM movies M1 ,movies M2
WHERE M1.mid  != M2.mid;

/*Normalized rating difference*/
CREATE VIEW rating_diff AS
SELECT M1.mid AS mid1, M2.mid AS mid2, 1-(ABS(M1.rating-M2.rating)/M1.rating)  AS diff
FROM movies M1 ,movies M2
WHERE M1.mid != M2.mid AND M1.rating!= 0;

/*Similarity Percentage View*/
CREATE VIEW similarity_percentage AS
SELECT M1.mid AS mid1 , M2.mid AS mid2 , (f1.diff + f2.diff + f3.diff + YD.diff + RD.diff)*100.0/5.0 AS Sim
FROM movies M1,movies M2,fraction_of_common_actors f1,fraction_of_common_tags f2, fraction_of_common_genres f3,year_diff YD ,rating_diff RD
WHERE M1.mid = f1.mid1 AND M2.mid = f1.mid2 AND M1.mid = f2.mid1 AND M2.mid = f2.mid2 AND M1.mid = f3.mid1 AND M2.mid = f3.mid2 AND M1.mid = YD.mid1 AND M2.mid = YD.mid2 AND M1.mid = RD.mid1 AND M2.mid = RD.mid2 AND M1.mid  != M2.mid;

/* Query*/
SELECT M2.title, M2.rating,S.Sim
FROM similarity_percentage S, movies M1,movies M2
WHERE S.mid1 = m1.mid AND m1.title= 'Mr. & Mrs. Smith' AND S.mid2=M2.mid
ORDER BY S.Sim DESC
LIMIT 10;
