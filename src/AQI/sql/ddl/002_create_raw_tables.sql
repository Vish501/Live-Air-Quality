-- Script: 002_create_raw_tables.sql
-- Table: raw.air_quality_data
-- Purpose: Stores raw air quality measurements ingested from source files.
-- Notes:
--   - No unique or primary key constraints to preserve the source data exactly as received.
--   - Includes location, sensor, and measurement details (parameter, units, value, coordinates).
--   - 'month' and 'year' columns support lightweight partitioning and analysis.
--   - 'ingestion_datetime' records when the data was ingested into the system.
--   - Serves as the immutable foundation layer before any cleaning, transformation, or enrichment.

CREATE TABLE IF NOT EXISTS raw.air_quality_data (
    location_id BIGINT,
    sensors_id BIGINT,
    "location" VARCHAR,
    "datetime" TIMESTAMP,
    lat DOUBLE,
    lon DOUBLE,
    "parameter" VARCHAR,
    units VARCHAR,
    "value" DOUBLE,
    "month" VARCHAR,
    "year" BIGINT,
    ingestion_datetime TIMESTAMP,
    source_file VARCHAR,
);