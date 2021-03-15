CREATE TABLE movies(
mid INTEGER NOT NULL,
title VARCHAR(255),
year VARCHAR(255),
rating VARCHAR(255),
num_rating INTEGER,
--CONSTRAINT CHK_Rating CHECK (rating>=0 AND rating<=5), 
PRIMARY KEY(mid));

ALTER TABLE movies ALTER COLUMN year TYPE INTEGER USING year::integer;

UPDATE movies
SET rating = REPLACE(rating, '\N', null)
WHERE rating = '\N'

UPDATE movies
SET num_rating = REPLACE(num_rating, '\N', null)
WHERE num_rating = '\N'

ALTER TABLE movies ALTER COLUMN rating TYPE REAL USING rating::real;

ALTER TABLE movies ALTER COLUMN num_rating TYPE INTEGER USING num_rating::integer;

CREATE TABLE actors(
mid INTEGER NOT NULL,
name VARCHAR(255) NOT NULL,
cast_position INTEGER,
FOREIGN KEY(mid) REFERENCES movies(mid),
PRIMARY KEY(mid, name));

CREATE TABLE genres(
mid INTEGER NOT NULL,
genre VARCHAR(255) NOT NULL,
FOREIGN KEY(mid) REFERENCES movies(mid),
PRIMARY KEY(mid, genre));

CREATE TABLE tag_names(
tid INTEGER NOT NULL,
tag VARCHAR(255),
PRIMARY KEY(tid));

CREATE TABLE tags(
mid INTEGER NOT NULL,
tid INTEGER NOT NULL,
FOREIGN KEY(mid) REFERENCES movies(mid),
FOREIGN KEY(tid) REFERENCES tag_names(tid),
PRIMARY KEY(mid, tid));
