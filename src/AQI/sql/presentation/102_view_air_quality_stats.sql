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