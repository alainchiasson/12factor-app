-- Loads an inital set of data into a test database.
DROP DATABASE IF EXISTS 12factor;
CREATE DATABASE 12factor;
USE 12factor;
CREATE TABLE users (
           id INT NOT NULL AUTO_INCREMENT,
           username VARCHAR(80) NOT NULL,
           email VARCHAR(120) NOT NULL,
           PRIMARY KEY (id),
           UNIQUE INDEX (username),
           UNIQUE INDEX (email)
);
INSERT INTO users VALUES (1, "admin", "admin@example.com");
INSERT INTO users VALUES (2, "guest", "guest@example.com");
