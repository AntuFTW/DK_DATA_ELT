use role accountadmin;

-- Create warehouse, database and schema
create or replace warehouse dk_wh with warehouse_size='x-small';
create database if not exists DK_ANALYTICS;
use database DK_ANALYTICS;
create or replace schema RAW;
use schema RAW;

-- Create role and grant trust and access policies
create or replace role dk_dbt_role;
grant usage on warehouse dk_wh to role dk_dbt_role;
grant role dk_dbt_role to user DKASSESSMENT;
grant all on database DK_ANALYTICS to role dk_dbt_role;
use role dk_dbt_role;