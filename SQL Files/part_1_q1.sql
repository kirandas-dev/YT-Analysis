-- Created a database called yt
CREATE DATABASE yt;

USE DATABASE yt;

-- Setup storage integration with Azure Blob
CREATE STORAGE INTEGRATION data_integration 
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = AZURE
  ENABLED = TRUE
  AZURE_TENANT_ID = 'e8911c26-cf9f-4a9c-878e-527807be8791'
  STORAGE_ALLOWED_LOCATIONS = ('azure://deassignment1.blob.core.windows.net/youtube-trending-analysis');

-- Get AZURE_MULTI_TENANT_APP_NAME
DESC STORAGE INTEGRATION data_integration;

CREATE OR REPLACE STAGE stage_data_integration 
STORAGE_INTEGRATION = data_integration 
URL='azure://deassignment1.blob.core.windows.net/youtube-trending-analysis';

-- Validate the files
list @stage_data_integration;


-- CSV File Format Definition 
CREATE OR REPLACE FILE FORMAT file_format_csv
TYPE = 'CSV'
FIELD_DELIMITER = ','
SKIP_HEADER = 1
NULL_IF = ('\\N', 'NULL', 'NUL', '')
FIELD_OPTIONALLY_ENCLOSED_BY = '"'
;
--Created an External Table 
CREATE OR REPLACE EXTERNAL TABLE ex_table_youtube_trending
WITH LOCATION = @stage_data_integration
FILE_FORMAT = file_format_csv
PATTERN = '.*\.csv';

-- Created an internal table from the reference table in the external stage
CREATE OR REPLACE  TABLE ext_table_youtube_trending AS
SELECT *, split_part(metadata$filename, '_', 1) AS Country
FROM ex_table_youtube_trending;


--Json file format definition
CREATE OR REPLACE FILE FORMAT file_format_json
  TYPE = 'JSON';

--Created a table by pulling JSON files from Blog Storage
CREATE OR REPLACE EXTERNAL TABLE ex_table_youtube_category
WITH LOCATION = @stage_data_integration
FILE_FORMAT = (TYPE=JSON)
PATTERN = '.*\.json';

--Created an internal table from the reference table and joined the Country column
CREATE OR REPLACE TABLE table_youtube_category AS
SELECT 
split_part(metadata$filename, '_', 1) AS Country,
l.value:id::INT AS CATEGORYID,
l.value:snippet.title::varchar AS CATEGORY_TITLE
FROM  ex_table_youtube_category,
LATERAL FLATTEN(INPUT => VALUE:items) AS l;


-- Defining the internal table data types for each column
CREATE OR REPLACE TABLE table_youtube_trending AS
SELECT
  value:c1::varchar as VIDEO_ID,
  value:c2::varchar as TITLE,
  TO_TIMESTAMP(value:c3) AS PUBLISHEDAT,
  value:c4::varchar as CHANNELID,
  value:c5::varchar as CHANNELTITLE,
  value:c6::int as CATEGORYID,
  TO_DATE(value:c7) AS TRENDING_DATE,
  value:c8::int as VIEW_COUNT,
  value:c9::int as LIKES,
  value:c10::int as DISLIKES,
  value:c11::int as COMMENT_COUNT,
  value:c12::varchar as COMMENTS_DISABLED,
  COUNTRY
FROM ext_table_youtube_trending;

--Merging the two tables 
CREATE OR REPLACE TABLE table_youtube_final AS
SELECT
    uuid_string() AS id,
    t.video_id,
    t.title,
    t.publishedat,
    t.channelid,
    t.channeltitle,
    t.categoryid,
    c.category_title,
    t.trending_date,
    t.view_count,
    t.likes,
    t.dislikes,
    t.comment_count,
    t.comments_disabled,
    t.country
FROM
    table_youtube_trending t
LEFT JOIN
    table_youtube_category c
ON
    t.categoryid = c.categoryid and t.country = c.country;

--Copying the merged back to Blog for backup. 
COPY INTO @stage_data_integration/table_youtube_final.csv
FROM table_youtube_final
FILE_FORMAT =(
    type = CSV
    COMPRESSION = none
    
    FIELD_OPTIONALLY_ENCLOSED_BY='"'
    NULL_IF=()
)

HEADER = TRUE
SINGLE = TRUE 

max_file_size=4900000000;

--Checking the number of rows of the merged table.
SELECT COUNT(*) FROM table_youtube_final;













