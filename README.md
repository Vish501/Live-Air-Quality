# Live-Air-Quality

A real-time air quality monitoring dashboard built with Python, DuckDB, Plotly Dash, and the OpenAQ API.
This project ingests live environmental data, processes it into daily statistics, and visualizes pollution levels with interactive charts.

# 🚀 Features

- Data Ingestion
-- Pulls live air quality data from the OpenAQ API
-- Uses DuckDB as the local analytical database.
-- Supports automated updates of daily statistics.
- Data Processing
-- Cleans raw data (filters invalid values like value <= 0 for pm25, o3, etc.).
-- Aggregates data by city, parameter, and date into daily statistics.
-- Exports processed results into records for visualization.
- Visualization
-- Interactive Plotly Dash dashboard.
-- Line plots and time series trends for pollutants across cities.
-- Handles missing periods gracefully (no line drawn if data absent).
- SQL Workflow
-- Stores queries in .sql files.
-- Functions to load, execute, and manage SQL queries programmatically.
-- Ensures DB connections are closed safely after execution.