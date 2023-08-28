-- DROP TABLE
DROP TABLE IF EXISTS TOTAL_FILM_DIRECTOR CASCADE;
DROP TABLE IF EXISTS TOTAL_FILM_LIKE CASCADE;
DROP TABLE IF EXISTS TOTAL_GENRE_FILM CASCADE;
DROP TABLE IF EXISTS TOTAL_USER_FRIENDS CASCADE;
DROP TABLE IF EXISTS TOTAL_USER_EVALUTION_REVIEW;
DROP TABLE IF EXISTS ROSTER_MPA CASCADE;
DROP TABLE IF EXISTS ROSTER_GENRE CASCADE;
DROP TABLE IF EXISTS ROSTER_STATUS_FRIENDS CASCADE;
DROP TABLE IF EXISTS ROSTER_EVALUATION CASCADE;
DROP TABLE IF EXISTS ROSTER_TYPE_REVIEW CASCADE;
DROP TABLE IF EXISTS ROSTER_EVENT_TYPE CASCADE;
DROP TABLE IF EXISTS EVENTS CASCADE;
DROP TABLE IF EXISTS DIRECTORS CASCADE;
DROP TABLE IF EXISTS REVIEWS CASCADE;
DROP TABLE IF EXISTS FILMS CASCADE;
DROP TABLE IF EXISTS USERS CASCADE;

-- CREATE TABLES
CREATE TABLE IF NOT EXISTS ROSTER_MPA (
    id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    description VARCHAR NOT NULL,
    CONSTRAINT UC_ROSTER_MPA_NAME UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS ROSTER_GENRE (
    id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    CONSTRAINT UC_ROSTER_GENRE_NAME UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS ROSTER_STATUS_FRIENDS (
    id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    CONSTRAINT UC_ROSTER_STATUS_FRIENDS_NAME UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS ROSTER_TYPE_REVIEW (
    id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name varchar(30) NOT NULL,
    CONSTRAINT UC_ROSTER_TYPE_REVIEW_NAME UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS ROSTER_EVALUATION (
    id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name varchar(30) NOT NULL,
    CONSTRAINT UC_ROSTER_EVALUATION_NAME UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS ROSTER_EVENT_TYPE (
    id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name varchar(30) NOT NULL,
    CONSTRAINT UC_ROSTER_EVENT_TYPE_NAME UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS USERS (
    id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    birthday DATE NOT NULL,
    login VARCHAR(30) NOT NULL,
    email VARCHAR(50) NOT NULL,
    CONSTRAINT UC_USERS_LOGIN UNIQUE (login),
    CONSTRAINT UC_USERS_EMAIL UNIQUE (email)
);

CREATE TABLE IF NOT EXISTS FILMS (
    id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    mpa_id INTEGER REFERENCES ROSTER_MPA (id) ON DELETE SET NULL,
    rate INTEGER DEFAULT 0,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(200) NOT NULL DEFAULT '',
    release_date DATE NOT NULL,
    duration INTEGER NOT NULL,
    CONSTRAINT UC_FILMS_NAME UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS EVENTS (
    id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    user_id INTEGER REFERENCES USERS (id) ON DELETE CASCADE,
    type_id INTEGER REFERENCES ROSTER_EVENT_TYPE (id) ON DELETE CASCADE,
    timestamp timestamp,
    entity_id INTEGER,
    CONSTRAINT FK_ENTITY_USER_ID FOREIGN KEY (entity_id) REFERENCES USERS(id),
    CONSTRAINT FK_ENTITY_FILM_ID FOREIGN KEY (entity_id) REFERENCES FILMS(id)
);

CREATE TABLE IF NOT EXISTS DIRECTORS (
    id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS REVIEWS (
    id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    content VARCHAR(200) NOT NULL,
    user_id INTEGER REFERENCES USERS (id) ON DELETE CASCADE,
    film_id INTEGER REFERENCES FILMS (id) ON DELETE CASCADE,
    type_id INTEGER REFERENCES ROSTER_TYPE_REVIEW (id) ON DELETE CASCADE,
    evalution_id INTEGER REFERENCES ROSTER_EVALUATION (id) ON DELETE CASCADE,
    useful INTEGER DEFAULT 0
);

CREATE TABLE IF NOT EXISTS TOTAL_FILM_LIKE (
    film_id INTEGER REFERENCES FILMS (id) ON DELETE CASCADE,
    user_id INTEGER REFERENCES USERS (id) ON DELETE CASCADE,
    PRIMARY KEY (film_id, user_id)
);

CREATE TABLE IF NOT EXISTS TOTAL_GENRE_FILM (
    film_id INTEGER NOT NULL REFERENCES FILMS (id) ON DELETE CASCADE,
    genre_id INTEGER NOT NULL REFERENCES ROSTER_GENRE (id) ON DELETE CASCADE,
    PRIMARY KEY (film_id, genre_id)
);

CREATE TABLE IF NOT EXISTS TOTAL_USER_FRIENDS (
    user_id INTEGER REFERENCES USERS (id) ON DELETE CASCADE,
    friend_id INTEGER REFERENCES USERS (id) ON DELETE CASCADE,
    status_id INTEGER REFERENCES ROSTER_STATUS_FRIENDS (id) ON DELETE SET NULL,
    PRIMARY KEY (user_id, friend_id)
);

CREATE TABLE IF NOT EXISTS TOTAL_USER_EVALUTION_REVIEW (
	review_id INTEGER REFERENCES REVIEWS (id) ON DELETE CASCADE,
    user_id INTEGER REFERENCES USERS (id) ON DELETE CASCADE,
    isPositive boolean NOT NULL
);

CREATE TABLE IF NOT EXISTS TOTAL_FILM_DIRECTOR (
    film_id INTEGER REFERENCES FILMS (id) ON DELETE CASCADE,
    director_id INTEGER REFERENCES DIRECTORS (id) ON DELETE CASCADE,
    PRIMARY KEY (film_id, director_id)
);
