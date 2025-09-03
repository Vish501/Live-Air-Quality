-- Script: 100_create_presentation_air_quality_data.sql
-- View: presentation.air_quality_data
-- Purpose: Provides a cleaned, deduplicated view of air quality data for analysis and reporting. 
-- Notes:
--   - Uses ROW_NUMBER to retain only the latest record per (location_id, sensors_id, datetime, parameter).
--   - Currently restricted to parameters 'pm25' and 'o3'.
--   - Ensures consistent and up-to-date values are available in the presentation layer.

CREATE OR REPLACE VIEW presentation.air_quality_data AS (
    WITH ranked_data AS (
        SELECT
            *,
            ROW_NUMBER() OVER (
                PARTITION BY location_id, sensors_id, "datetime", "parameter"
                ORDER BY ingestion_datetime DESC
            ) AS rn
        FROM raw.air_quality_data
        WHERE parameter IN ('pm25', 'o3')
            AND "value" >= 0
    )

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
        "year"
    FROM ranked_data
    WHERE rn = 1
);