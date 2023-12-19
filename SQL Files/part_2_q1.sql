-- Select distinct category titles where there are duplicates within each country.
SELECT distinct category_title
FROM table_youtube_category
GROUP BY country, category_title
HAVING COUNT(category_title) > 1;
