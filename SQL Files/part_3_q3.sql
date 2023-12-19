--
-- This SQL query identifies the top-ranked video by view count and likes ratio for each country in each month.
--

-- Ranking Videos by View Count and Likes Ratio
-- This query uses the 'table_youtube_final' dataset to identify the top-ranked video by view count and likes ratio
-- for each country in each month. It partitions the data by 'country' and 'year_month' (formatted as 'YYYY-MM-01')
-- and calculates the likes ratio as a percentage.
--
-- The ROW_NUMBER() function assigns a rank to each video within its country and month, and the query selects
-- videos with a rank of 1, which corresponds to the top-ranked video.
--
WITH VideoRank AS (
    SELECT
        country,
        TO_CHAR(trending_date, 'YYYY-MM-01') AS year_month,
        title,
        channeltitle,
        view_count,
        likes,
        ROUND((likes / view_count) * 100, 2) AS likes_ratio,
        ROW_NUMBER() OVER (PARTITION BY country, TO_CHAR(trending_date, 'YYYY-MM-01') ORDER BY view_count DESC) AS RowNum
    FROM
        table_youtube_final
)
SELECT
    country,
    year_month,
    title,
    channeltitle,
    view_count,
    likes_ratio
FROM
    VideoRank
WHERE
    RowNum = 1
ORDER BY
    year_month,
    country;
