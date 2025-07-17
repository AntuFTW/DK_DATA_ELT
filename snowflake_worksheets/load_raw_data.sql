use role accountadmin;
use schema DK_ANALYTICS.RAW;

-- Create file format for internal stage
create or replace file format dk_csv_format
    type = CSV
    field_delimiter = ','
    skip_header = 1
    field_optionally_enclosed_by = '"'
    comment = 'CSV file format to load DK books data into stage';
    
-- Create snowflake internal stage
create or replace stage dk_data
    encryption = (type = 'SNOWFLAKE_SSE')
    file_format = dk_csv_format;

-- Create RAW_STORE_SALES
create or replace table RAW_STORE_SALES (
    CREATED_AT TIMESTAMP,
    UPDATED_AT TIMESTAMP,
    STORE_NUMBER NUMBER,
    STORE_NAME VARCHAR,
    AREA_NUMBER NUMBER,
    AREA_NAME VARCHAR,
    ISBN VARCHAR, -- To prevent stripping 0
    AUTHOR VARCHAR, -- This column contains null values which should be dealt with
    TITLE VARCHAR,
    PUBLISHER VARCHAR,
    IMPRINT VARCHAR,
    AVAILABILITY VARCHAR,
    RRP FLOAT,
    CORE_STOCK_FLAG VARCHAR,
    PUBLICATION_DATE VARCHAR, -- Cast to date later as its in DD/MM/YYYY format which snowflake does not accept
    PRODUCT_GROUP VARCHAR,
    DEPARTMENT VARCHAR,
    SUB_DEPARTMENT VARCHAR,
    CLASS VARCHAR,
    QTY_ON_HAND NUMBER,
    QTY_ON_ORDER NUMBER,
    QTY_RECEIVED NUMBER,
    QTY_RETURNED NUMBER,
    QTY_SOLD NUMBER,
    HUB_QTY_ON_HAND NUMBER,
    HUB_QTY_ON_ORDER NUMBER);

-- Copy local CSV into Snowflake stage
PUT 'file://snowflake_worksheets/store_sales.csv' 
@DK_DATA;

-- Copy CSV into RAW_STORE_SALES table
copy into RAW_STORE_SALES
FROM @dk_data/store_sales.csv;

-- Checks if the table has been created
SELECT * FROM raw_store_sales
LIMIT 5;