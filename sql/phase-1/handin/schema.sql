CREATE TABLE IF NOT EXISTS Movies (
    mid INTEGER NOT NULL,
    title VARCHAR(255),
    year INTEGER,
    rating REAL,
    num_ratings INTEGER,
    PRIMARY KEY(mid)
);

CREATE TABLE IF NOT EXISTS Actors (
    mid INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL,
    cast_position INTEGER,
    FOREIGN KEY(mid) REFERENCES movies(mid),
    PRIMARY KEY(mid, name)
);

CREATE TABLE IF NOT EXISTS Genres (
    mid INTEGER NOT NULL,
    genre VARCHAR(255) NOT NULL,
    FOREIGN KEY(mid) REFERENCES movies(mid),
    PRIMARY KEY(mid, genre)
);

CREATE TABLE IF NOT EXISTS Tag_names (
    tid INTEGER NOT NULL,
    tag VARCHAR(255),
    PRIMARY KEY(tid)
);

CREATE TABLE IF NOT EXISTS Tags (
    mid INTEGER NOT NULL,
    tid INTEGER NOT NULL,
    FOREIGN KEY(mid) REFERENCES movies(mid),
    FOREIGN KEY(tid) REFERENCES tag_names(tid),
    PRIMARY KEY(mid, tid)
);
