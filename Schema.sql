CREATE TABLE netflix (
     show_id	VARCHAR(6),
     types      VARCHAR(10),
     title      VARCHAR(150),
     director   VARCHAR(250),
     casts	    VARCHAR(1000),
     country	VARCHAR(150),
     date_added	VARCHAR(50),
     release_year INT,
     rating	     VARCHAR(10),
     duration	 VARCHAR(15),
     listed_in	 VARCHAR(300),
     description VARCHAR(300)
);
SELECT * FROM netfix;
SELECT * FROM netflix;
SELECT COUNT(*) as total_content FROM netflix;
SELECT DISTINCT types FROM netflix;
