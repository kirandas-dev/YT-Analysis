
--Selecting the video in table_youtube_final, which doesn’t have a channeltitle
SELECT *
FROM table_youtube_final
WHERE channeltitle IS NULL;
