--
-- This SQL query counts the distinct number of videos related to BTS in each country.
--

-- Counting BTS-Related Videos per Country
-- This query counts the number of distinct video IDs in the 'table_youtube_final' dataset for each country
-- where the video title contains 'BTS' (case-insensitive, thanks to ILIKE).
-- It groups the results by 'country' and orders them in descending order based on the count (ct).
--
SELECT
    country,
    COUNT(DISTINCT video_id) AS ct
FROM
    table_youtube_final
WHERE
    title ILIKE '%BTS%'
GROUP BY
    country
ORDER BY
    ct DESC;
