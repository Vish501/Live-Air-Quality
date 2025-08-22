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
    current_timestamp AS ingestion_datetime
    '{{ file_name }}' AS file_name
FROM read_csv('{{ data_file_path }}');