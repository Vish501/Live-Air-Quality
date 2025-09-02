-- Script: 010_load_raw_air_quality.sql
-- Purpose: 
--   - Load CSV files (downloaded from public S3) into raw.air_quality_data with metadata.
--   - Insert into raw.air_quality_data with ingestion metadata.
--   - Log file ingestion details into raw.file_ingestion_log.

-- Step 1: Load CSV into a temporary table with a load timestamp
CREATE TEMP TABLE tmp_stamped AS
SELECT 
    src.*,
    current_timestamp AS load_ts
FROM read_csv('{{ data_file_path }}') src;

-- Step 2: Insert staged data into raw.air_quality_data
INSERT INTO raw.air_quality_data
SELECT 
    location_id, 
    sensors_id, 
    "location", 
    "datetime", 
    lat, 
    lon, 
    "parameter", 
    units, 
    "value",
    "month", 
    "year",
    load_ts AS ingestion_datetime,             -- when loaded into DB
    '{{ file_name }}' AS source_file           -- original file source (e.g. OpenAQ)
FROM tmp_stamped;                                      

-- Step 3: Log ingestion metadata (for audit & deduplication checks)
INSERT INTO raw.file_ingestion_log (source_file, record_count, "status", ingestion_datetime)
SELECT
    '{{ file_name }}',
    COUNT(*),           -- total records ingested
    'SUCCESS',          -- hardcoded success flag
    MAX(load_ts)
FROM tmp_stamped;

-- Step 4: Clean up temporary staging table
DROP TABLE tmp_stamped;