-- Script: 010_load_raw_air_quality.sql
-- Purpose: Load CSV files (downloaded from public S3) into raw.air_quality_data with metadata.
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
    current_timestamp AS ingestion_datetime,   -- when loaded into DB
    '{{ file_name }}' AS file_name             -- original file name from artifacts/
FROM read_csv('{{ data_file_path }}');        -- e.g. artifacts/openaq_2025_08_21.csv