-- We initially thought to calculate the monthly counts of trending videos per category
WITH MonthlyTrendingCounts AS (
    SELECT
        TO_CHAR(CAST(trending_date AS DATE), 'YYYY-MM') AS year_month,
        category_title,
        COUNT(*) AS num_trending_videos
    FROM
        table_youtube_final
    GROUP BY
        year_month,
        category_title
    ORDER BY
        year_month
)
-- And then retrieve the monthly trending counts for each category but then it made more sense to take an 
-- aggregate approach -Calculating(view_count + likes - dislikes)
SELECT
    year_month,
    category_title,
    num_trending_videos
FROM
    MonthlyTrendingCounts
ORDER BY
    year_month,
    category_title;

-- Calculate aggregated engagement metrics per category, excluding 'Music' and 'Entertainment'
SELECT
    EXTRACT(YEAR FROM CAST(trending_date AS DATE)) AS year,
    category_title,
    SUM(likes) AS total_likes,
    SUM(dislikes) AS total_dislikes,
    SUM(view_count) AS total_views,
    SUM(view_count + likes - dislikes) AS aggregated_value
FROM
    table_youtube_final
WHERE
    category_title NOT IN ('Music', 'Entertainment')
GROUP BY
    year, category_title
ORDER BY
    year, category_title
LIMIT 200;
