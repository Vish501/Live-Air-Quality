-- Script: 001_schema_creation.sql
-- Purpose: Defines the database schemas used in the pipeline.
-- Schemas:
--   - raw: Stores unprocessed data ingested directly from source files along with metadata logs.
--   - presentation: Stores cleaned, transformed, and aggregated datasets prepared for analysis and dashboards.
-- Notes:
--   - Keeping raw and presentation separate ensures a clear data lineage.
--   - The raw schema acts as an immutable source-of-truth layer.
--   - The presentation schema provides a curated layer optimized for reporting and analytics.

-- Create schema for raw ingested data
CREATE SCHEMA IF NOT EXISTS "raw";

-- Create schema for presentation views
CREATE SCHEMA IF NOT EXISTS "presentation";