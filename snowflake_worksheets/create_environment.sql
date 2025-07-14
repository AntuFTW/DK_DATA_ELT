use role accountadmin;

-- Create warehouse, database and schema
create or replace warehouse dk_wh with warehouse_size='x-small';
create database if not exists DK_ANALYTICS;
use database DK_ANALYTICS;
create or replace schema RAW;
create or replace schema ANALYTICS;

-- Create role and grant trust and access policies
create or replace role dk_dbt_role;
grant usage on warehouse dk_wh to role dk_dbt_role;
grant role dk_dbt_role to user DKASSESSMENT;
grant all on database DK_ANALYTICS to role dk_dbt_role;
grant usage on schema DK_ANALYTICS.RAW TO ROLE dk_dbt_role;
grant select on all tables in schema DK_ANALYTICS.RAW to role dk_dbt_role;
grant select on future tables in schema DK_ANALYTICS.RAW to role dk_dbt_role;
grant usage on schema DK_ANALYTICS.ANALYTICS TO ROLE dk_dbt_role;
grant select on future tables in schema DK_ANALYTICS.ANALYTICS to role dk_dbt_role;
grant create table, create view on schema DK_ANALYTICS.ANALYTICS to role dk_dbt_role;
use role dk_dbt_role;