-- NetfixProject

-- 15 Business Problems & Solutions

-- 1. Count the number of Movies vs TV Shows
SELECT * FROM netflix;
SELECT types FROM netflix;
SELECT types, COUNT(*) as total_content FROM netflix GROUP BY types;

-- 2. Find the most common rating for movies and TV shows
SELECT types , rating , COUNT(*), RANK()OVER(PARTITION BY types ORDER BY count(*)) as ranking FROM netflix GROUP BY 1, 2;

-- 3. List all movies released in a specific year (e.g., 2020)
SELECT * FROM netflix 
WHERE types = 'Movie' AND release_year = '2020';

--4. Find the top 5 countries with the most content on Netflix
SELECT 
      UNNEST(STRING_TO_ARRAY(country ,',')) as new_country,
	  COUNT(show_id) as total_content FROM netflix GROUP BY new_country ORDER BY total_content DESC
	  limit 5;
 

-- 5. Identify the longest movie
SELECT * FROM netflix 
WHERE types = 'Movie' AND duration = (SELECT MAX(duration) FROM netflix);

-- 6. Find content added in the last 5 years
SELECT * FROM netflix 
WHERE TO_DATE(date_added,'Month DD, YYYY') >= CURRENT_DATE - INTERVAL ' 5 years';

-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
SELECT * FROM netflix 
WHERE director ILIKE '%Rajiv Chilaka%';

-- 8. List all TV shows with more than 5 seasons
SELECT * FROM netflix 
WHERE types = 'TV Show' AND SPLIT_PART(duration ,' ',1)::numeric > 5 ;

-- 9. Count the number of content items in each genre
SELECT UNNEST(STRING_TO_ARRAY(listed_in , ',')) as genre ,
count(show_id) as total_content FROM netflix GROUP BY 1; 

-- 10.Find each year and the average numbers of content release in India on netflix.return top 5 year with highest avg content release!
SELECT 
     EXTRACT(YEAR FROM TO_DATE(date_added , 'Month DD , YYYY')) as Year,
     COUNT(*) ,
     COUNT(*)::numeric/(SELECT COUNT(*) FROM netflix WHERE country = 'India') * 100 as average_per_year
FROM netflix WHERE country = 'India' GROUP BY Year;

-- 11. List all movies that are documentaries
SELECT * FROM netflix 
WHERE listed_in ILIKE '%documentaries%';

-- 12. Find all content without a director
SELECT * FROM netflix 
WHERE director IS NULL;

-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
SELECT * FROM netflix 
WHERE casts ILIKE '%Salman Khan%' AND release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;

-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
SELECT 
	 UNNEST(STRING_TO_ARRAY(casts , ',')) as actors ,
	 COUNT(*) as total_content FROM netflix 
	 WHERE country ILIKE '%India'
	 GROUP BY actors ORDER BY total_content DESC LIMIT 10;

-- 15.Categorize the content based on the presence of the keywords 'kill' and 'violence' in content as 'Good'. Count how many items fall into each category.
WITH new_table AS (
      SELECT * , 
      CASE
       WHEN
		   description iLIKE '%kill%' OR description iLIKE '%voilence%' then 'Bad_Content'
		   ELSE 'Good_Content'
		END catagory
FROM netflix
)
SELECT catagory ,
       COUNT(*) as total_content
FROM new_table GROUP BY 1 ;





