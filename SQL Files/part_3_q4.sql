--
-- This SQL query calculates the percentage of the most viewed video category within each country.
--

-- Calculating Percentage of Most Viewed Video Category
-- This query uses the 'table_youtube_final' dataset to calculate the percentage of the most viewed video category
-- within each country. It achieves this by first counting the number of distinct videos in each category for each
-- country ('VideoCounts'). It then identifies the maximum video count within each country ('MaxCategory').
-- Additionally, it calculates the total count of distinct videos for each country ('CountryTotal').
--
-- Finally, the query calculates the percentage by dividing the maximum video count by the total count and rounding
-- the result to two decimal places. The results are ordered by country and category title.
--
WITH VideoCounts AS (
    SELECT
        country,
        category_title,
        COUNT(DISTINCT video_id) AS video_count
    FROM
        table_youtube_final
    GROUP BY
        country, category_title
),
MaxCategory AS (
    SELECT
        country,
        MAX(video_count) AS max_count
    FROM
        VideoCounts
    GROUP BY
        country
),
CountryTotal AS (
    SELECT
        country,
        COUNT(DISTINCT video_id) AS total_count
    FROM
        table_youtube_final
    GROUP BY
        country
)
SELECT
    v.country,
    v.category_title,
    m.max_count as total_category_video,
    c.total_count AS total_country_video,
    ROUND((m.max_count::NUMERIC / c.total_count::NUMERIC) * 100, 2) AS percentage
FROM
    VideoCounts v
JOIN
    MaxCategory m
ON
    v.country = m.country AND v.video_count = m.max_count
JOIN
    CountryTotal c
ON
    v.country = c.country
ORDER BY
    v.country,
    v.category_title;
