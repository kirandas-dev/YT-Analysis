-- Select category titles that are unique to a single country.

SELECT category_title
FROM table_youtube_category
GROUP BY category_title
HAVING COUNT(DISTINCT Country) = 1;

