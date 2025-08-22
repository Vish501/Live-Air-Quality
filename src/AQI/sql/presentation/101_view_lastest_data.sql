-- Script: 101_create_latest_params_per_location_view.sql
-- View: presentation.latest_params_per_location
-- Purpose: Provides a pivoted view of the most recent air quality measurements 
--          (currently 'pm25' and 'o3') for each location.
-- Notes:
--   - Uses ROW_NUMBER() to identify the latest record per (location_id, parameter).
--   - Pivots parameters into separate columns, making the data easier to query 
--     for dashboards and downstream analysis.
--   - Ensures only the latest measurement per pollutant is retained per location.

CREATE OR REPLACE VIEW presentation.latest_params_per_location AS (
    WITH ranked_data AS (
        SELECT
            location_id,
            "location",
            "datetime", 
            lat, 
            lon, 
            "parameter", 
            "value",
            ROW_NUMBER() OVER (
                PARTITION BY location_id, "parameter"
                ORDER BY "datetime" DESC
            ) AS rn
        FROM presentation.air_quality_data
    )

    PIVOT (
        SELECT
            location_id,
            "location",
            lat, 
            lon,
            "datetime", 
            "parameter", 
            "value"
        FROM ranked_data
        WHERE rn = 1
    )

    ON parameter IN ('pm25', 'o3')
    USING FIRST("value")
);