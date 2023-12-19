-- Finding out the categoryid that has a missing category_title in table_youtube_final
SELECT DISTINCT categoryid
FROM table_youtube_final
WHERE category_title is null;
