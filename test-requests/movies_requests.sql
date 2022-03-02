-- SELECT REQUEST TO GET THE CLIENTS DETAILS --

SELECT
	movies.name AS Name,
  movies.genre AS Genre,
  movies.director AS Director,
  CONCAT(movies.duration, 'min') AS Duration,
  (SELECT 
    COUNT(screenings.screening_id) 
    FROM screenings
    WHERE screenings.movie = movies.movie_id
	) AS Screenings
FROM
	movies
ORDER BY Name
;

-- DISPLAYS (by Movie Name):

-- Movie Name,
-- Movie Genre,
-- Movie Director,
-- Movie Duration in minutes,
-- Total Screenings Count.