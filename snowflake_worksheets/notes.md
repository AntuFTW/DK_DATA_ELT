load_raw_data - this file creates a stage, file format and a table. it then uploads a file to a stage and then loads that file into the created table

the table has only varchar to make sure there are no errors when loading data in, however some of the values are null.

the create environment.sql creates the roles, schema, database warehouse and other important things for the snowflake environemnt

I am using both Snowcli and snowflake-cli, not sure which ones

each unique book store number will have the same store name/area name or soemthing else similar

check if all the columns i said were unique were actually unique