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