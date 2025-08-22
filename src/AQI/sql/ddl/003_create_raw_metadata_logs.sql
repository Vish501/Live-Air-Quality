-- Script: 003_create_raw_metadata_logs.sql
-- Table: raw.file_ingestion_log
-- Purpose: Tracks ingestion of every incoming file into the raw schema. 
-- Notes:
--   - No primary key to allow multiple ingestions of the same file (e.g., retries, corrections). 
--   - 'status' column indicates ingestion outcome ('SUCCESS' or 'FAILED').
--   - 'error_message' captures any failure details for audit/debugging.
--   - Ensures raw schema remains a faithful reflection of all data received.

CREATE TABLE IF NOT EXISTS raw.file_ingestion_log (
    file_name TEXT,
    ingestion_datetime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    record_count INT,
    status TEXT CHECK (status IN ('SUCCESS','FAILED')),
    error_message TEXT
);