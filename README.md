# YouTube Trending Video Analysis

## Overview

This project focuses on analyzing YouTube trending videos using Snowflake as a Data Lakehouse. The dataset includes daily records of top trending videos from different countries and regions. The analysis involves data ingestion, cleaning, analysis, and addressing specific business questions.

## Project Structure

- **Part 1: Data Ingestion**
  - SQL file: `part_1.sql`
  - Tasks:
    - Download and upload dataset to Azure storage
    - Ingest data into Snowflake
    - Transform and load data into tables

- **Part 2: Data Cleaning**
  - SQL files: `cleaning_question1.sql`, ..., `cleaning_question9.sql`
  - Tasks:
    - Identify and handle duplicate categories
    - Find categories appearing in only one country
    - Update missing category titles
    - Handle NULL values and video_id '#NAME?'
    - Remove duplicates in final table

- **Part 3: Data Analysis**
  - SQL files: `analysis_question1.sql`, ..., `analysis_question5.sql`
  - Tasks:
    - Find top three most viewed sports videos per country on '2021-10-17'
    - Count distinct videos with 'BTS' in the title per country
    - Identify most viewed video per country per month with likes ratio
    - Determine category with the most distinct videos per country
    - Find channel with the most distinct videos

- **Part 4: Business Question**
  - SQL file: `business_question.sql`
  - Tasks:
    - Determine recommended video category (excluding 'Music' and 'Entertainment')
    - Analyze strategy across countries

## Instructions

1. **Setup**
   - Ensure Snowflake account is set up
   - Set up Azure storage account

2. **Data Ingestion**
   - Execute `part_1.sql` in Snowflake
   - Download and upload datasets to Azure storage
   - Ingest data into Snowflake

3. **Data Cleaning**
   - Execute cleaning SQL files in order (`cleaning_question1.sql`, ..., `cleaning_question9.sql`)

4. **Data Analysis**
   - Execute analysis SQL files in order (`analysis_question1.sql`, ..., `analysis_question5.sql`)

5. **Business Question**
   - Execute `business_question.sql`

6. **Review Results**
   - Check CSV outputs in the `output/` directory for analysis results

## Report
Refer to the `handover_report.pdf` for a detailed report on the project, findings, and recommendations.

## Deliverables
- SQL queries: `part_1.sql`, `cleaning_question1.sql`, ..., `business_question.sql`
- CSV outputs: `output/analysis_question1.csv`, ..., `output/analysis_question5.csv`, `output/business_question.csv`
- Handover report: `handover_report.pdf`

## Assessment Criteria
The project will be evaluated based on code quality, data processing justification, result accuracy, findings quality, and report clarity.

## License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
