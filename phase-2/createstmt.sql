CREATE TABLE movies_metadata(
    id INTEGER NOT NULL,
    adult BOOLEAN,
    belongs_to_collection TEXT,
    budget INTEGER,
    genre VARCHAR,
    homepage VARCHAR,
    imdb_id VARCHAR,
    original_language VARCHAR(2),
    original_title TEXT,
    overview VARCHAR,
    popularity REAL,
    poster_path VARCHAR,
    production_companies VARCHAR,
    release_date TIMESTAMP,
    revenue INTEGER,
    runtime INTEGER,
    spoken_languages TEXT,
    "status" VARCHAR,
    tagline VARCHAR,
    title VARCHAR,
    video BOOLEAN,
    vote_average REAL,
    vote_count INTEGER,
    PRIMARY KEY(id)
);

CREATE TABLE keywords(
    id INTEGER NOT NULL,
    keywords VARCHAR,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES movies_metadata(id)
);

CREATE TABLE credits(
    id INTEGER NOT NULL,
    "cast" VARCHAR,
    crew VARCHAR,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES movies_metadata(id)
);

CREATE TABLE ratings(
    movieId INTEGER,
    userId INTEGER,
    rating REAL,
    timestamp TIMESTAMP,
    PRIMARY KEY (movieId, userId),
    FOREIGN KEY (movieId) REFERENCES movies_metadata(id)
);

CREATE TABLE ratings_small(
    movieId INTEGER,
    userId INTEGER,
    rating REAL,
    timestamp TIMESTAMP,
    PRIMARY KEY (movieId, userId),
    FOREIGN KEY (movieId) REFERENCES movies_metadata(id)
);

CREATE TABLE links(
    movieId INTEGER,
    imdbId INTEGER,
    tmdbId INTEGER,
    PRIMARY KEY (movieId),
    FOREIGN KEY (movieId) REFERENCES movies_metadata(id)
);

CREATE TABLE links_small(
    movieId INTEGER,
    imdbId INTEGER,
    tmdbId INTEGER,
    PRIMARY KEY (movieId),
    FOREIGN KEY (movieId) REFERENCES movies_metadata(id)
);