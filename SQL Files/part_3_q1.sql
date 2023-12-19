--
-- This SQL query identifies and ranks the top 3 trending sports videos in each country for the date '2021-10-17'.
--

-- Step 1: Ranking Sports Videos
-- In this Common Table Expression (CTE) named 'RankedVideos,' the script selects videos from the 'table_youtube_final' dataset 
-- that match the criteria of having a 'trending_date' of '2021-10-17' and a 'category_title' of 'Sports.'
-- It assigns a row number (Rank) to each video within its respective country, based on the 'view_count' in descending order.
--
WITH RankedVideos AS (
    SELECT
        t.country,
        t.video_id,
        t.title,
        t.view_count,
        t.category_title,
        ROW_NUMBER() OVER (PARTITION BY t.country ORDER BY t.view_count DESC) AS Rank
    FROM
        table_youtube_final AS t
  
    WHERE
        t.trending_date = '2021-10-17'
        AND t.category_title = 'Sports'
)

SELECT
    country,
    Rank,
    video_id,
    title,
    view_count,
    category_title
FROM
    RankedVideos
WHERE
    Rank <= 3
ORDER BY
    country,
    Rank;

    
-- Step 2 (above): Selecting the Top 3 Videos per Country
-- The main query selects and presents the top 3 ranked sports videos in each country.
-- It retrieves attributes such as 'country,' 'Rank,' 'video_id,' 'title,' 'view_count,' and 'category_title' from the 'RankedVideos' CTE.
-- Videos are ordered by 'country' and 'Rank' for clarity.
--
