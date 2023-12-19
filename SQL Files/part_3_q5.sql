--
-- This SQL query retrieves the channel with the highest number of distinct videos.
--

-- Channel with the Highest Number of Distinct Videos
-- This query selects the 'channeltitle' and counts the number of distinct 'video_id' entries in the 'table_youtube_final'
-- dataset. It groups the results by 'channeltitle' and orders them in descending order based on the count.
-- The 'LIMIT 1' clause ensures that only the channel with the highest number of distinct videos is returned.
--
SELECT
    channeltitle,
    COUNT(DISTINCT video_id) AS distinct_video_count
FROM
    table_youtube_final
GROUP BY
    channeltitle
ORDER BY
    distinct_video_count DESC
LIMIT 1;
