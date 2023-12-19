
--
-- This SQL script is used to identify and handle duplicate entries within the 'table_youtube_final' dataset.
--

-- Step 1: Identification of Duplicates
-- In this section, a Common Table Expression (CTE) named 'RankedDuplicates' is created.
-- It assigns a row number to each record based on specific criteria, such as 'video_id,' 'country,' and 'trending_date,' 
-- with rows ordered by 'view_count' in descending order.
-- This effectively ranks the records by view counts, with the most viewed records receiving a lower row number.
--
CREATE OR REPLACE TABLE table_youtube_duplicates AS
WITH RankedDuplicates AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY video_id, country, trending_date ORDER BY view_count DESC) AS RowNum
    FROM
        table_youtube_final
)

-- Step 2: Selection of Duplicate Records
-- The main query selects all records from the 'RankedDuplicates' CTE where the row number (RowNum) is greater than 1.
-- These are the records that have duplicates based on 'video_id,' 'country,' and 'trending_date' and are considered for removal.
--
SELECT *
FROM
    RankedDuplicates
WHERE
    RowNum > 1;
--Step 3 in the next sql script- part_2_q8

    

