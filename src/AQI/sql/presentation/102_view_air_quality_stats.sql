-- Script: 102_create_daily_stats_view.sql
-- View: presentation.daily_stats
-- Purpose: Provides daily aggregated air quality statistics (average values) 
--          per location and parameter, enriched with temporal context.
-- Notes:
--   - Aggregates raw measurements into daily averages by (location_id, parameter).
--   - Adds derived fields for weekday number, weekday name, and weekend indicator.
--   - Useful for analyzing day-to-day patterns, weekday vs. weekend trends, and 
--     feeding time series or forecasting models.

CREATE OR REPLACE VIEW presentation.daily_stats AS (
    WITH dated_data AS (
        SELECT
            location_id,
            "location",
            CAST("datetime" as DATE) as measurement_date, 
            lat, 
            lon, 
            "parameter",
            units,
            "value",
            dayofweek("datetime") AS weekday_number,
            dayname("datetime") AS weekday,
        CASE
            WHEN dayname("datetime") IN ('Saturday', 'Sunday')
            THEN 1
            ELSE 0
        END AS is_weekend
        FROM presentation.air_quality_data
    )

    SELECT
        location_id,
        "location",
        measurement_date,
        weekday_number,
        weekday,
        is_weekend,
        lat,
        lon,
        parameter,
        units,
        AVG(value) AS average_value
    FROM dated_data
    GROUP BY
        location_id,
        location,
        measurement_date,
        weekday_number,
        weekday,
        is_weekend,
        lat,
        lon,
        parameter,
        units
);