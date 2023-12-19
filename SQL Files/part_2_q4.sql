--Finding out the category_title from table_youtube_category using the categoryid which has a missing category_title in table_youtube_final
SELECT category_title
FROM table_youtube_category
WHERE categoryid =(SELECT DISTINCT categoryid
FROM table_youtube_final
WHERE category_title is null);


--Updating the missing category_title in table_youtube_final

UPDATE table_youtube_final
SET category_title = (
    SELECT category_title
    FROM table_youtube_category
    WHERE categoryid = (SELECT DISTINCT categoryid
FROM table_youtube_final
WHERE category_title IS NULL)
)
WHERE category_title IS NULL;

--Checking the records
SELECT distinct categoryid, category_title  FROM table_youtube_final order by categoryid asc;
