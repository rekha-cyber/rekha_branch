-- =========================================================================
-- schema.sql - the tables your database is made of
--
-- Project 1 | SQL: From Data to Insight
-- Team: Regina Khamatnurova
-- Dataset: Comparative Political Data Set (CPDS)
--
-- This is a DELIVERABLE: it is how someone rebuilds your database from
-- nothing, and the tables here must match the ERD you drew.
--
-- Written for SQLite. On MySQL, add a CREATE DATABASE / USE at the top and
-- swap the types (TEXT -> VARCHAR(n), REAL -> DECIMAL, INTEGER PRIMARY KEY
-- -> INT PRIMARY KEY AUTO_INCREMENT).
-- =========================================================================

-- SQLite does not enforce foreign keys unless you ask it to, once per
-- connection. Without this line a broken key is accepted in silence.
-- PRAGMA foreign_keys = ON;


-- --- Lookup tables -------------------------------------------------------
-- The categorical columns you pulled out: an id and the value it stands for.
-- These have no foreign keys of their own, so they are created and loaded
-- FIRST.

CREATE TABLE countries (
    country_id INTEGER PRIMARY KEY,
    country_name TEXT NOT NULL UNIQUE
);

CREATE TABLE government_types (
    government_type_id INTEGER PRIMARY KEY,
    government_type TEXT NOT NULL UNIQUE
);


-- --- Your main table -----------------------------------------------------
-- The rows you are actually analysing: the numbers you care about, plus one
-- foreign key pointing at each lookup table above. Created and loaded LAST,
-- because every key it carries has to already exist somewhere else.
CREATE TABLE country_year (
    observation_id INTEGER PRIMARY KEY,
    country_id INTEGER NOT NULL,
    government_type_id INTEGER NOT NULL,
    year INTEGER NOT NULL,

    left_percentage REAL,
    centre_percentage REAL,
    right_percentage REAL,
    gdp_growth REAL,
    unemployment REAL,
    inflation REAL,

    UNIQUE (country_id, year),

    FOREIGN KEY (country_id)
        REFERENCES countries(country_id),

    FOREIGN KEY (government_type_id)
        REFERENCES government_types(government_type_id)
);




-- --- Indexes (optional) --------------------------------------------------
-- Worth adding on your foreign keys if a query starts to feel slow.
