
-- Step 3: Deletion of Duplicate Records
-- This section deletes the identified duplicate records from the 'table_youtube_final' table using a DELETE statement.
-- It specifies the records to be deleted based on a multi-column condition involving 'id,' 'video_id,' 'country,' 
-- 'trending_date,' and other attributes, matching those found in the 'table_youtube_duplicates' CTE.
--
DELETE FROM table_youtube_final
WHERE (id, video_id, country, trending_date, title, publishedat, channelid, channeltitle, categoryid, category_title, comments_disabled, likes, dislikes, comment_count) IN (
    SELECT id, video_id, country, trending_date, title, publishedat, channelid, channeltitle, categoryid, category_title, comments_disabled, likes, dislikes, comment_count 
    FROM table_youtube_duplicates
);
