# [Modeling DK sale data for analysis]

---

## 🛠️ Prerequisites & Setup

Before you begin, ensure you have the following installed and configured:

* **Python**: A Python environment to run dbt.
* **Snowflake Account**: Access to a Snowflake account with a user, password, role, and warehouse.
* **SnowCLI**: Needed to run Snowflake commands from the terminal.

### 1. Create Snowflake environment and Load data into RAW table
After setting up SnowCLI and connecting it to your Snowflake account, run the two commands bellow from the root of this repository. These set up the Snowflake environment and then load data into an internal Snowflake stage and then copy this data into a RAW data table which is referenced by dbt.

`snow sql --connection <name_of_snowflake_connection> --filename snowflake_worksheets/create_environment.sql`

`snow sql --connection <name_of_snowflake_connection> --filename snowflake_worksheets/load_raw_data.sql`

### 2. Download dbt core and set up Python environment (commands are for MacOS)
Move to the `dbt_transform` directory and create a virtual environment. Activate the venv then download the requirements in the `requirements.txt` file.

`python3 -m venv .venv` -> Creates venv
`source .venv/bin/activate` -> Activates venv
`pip3 install -r requirements.txt` -> Downloads dependencies in venv

### 3. Run dbt models and generate dbt documentation
The dbt models created are explained in this read me, but alternatively you can create the documentation and host this locally.
First download dbt package dependencies. After this build all the models and if everything runs successfully then tables will materialise in the `ANALYTICS` schema as tables.

`dbt deps` -> Downloads the dbt packages
`dbt build` -> Builds and tests all the dbt models
`dbt docs generate` -> Generates documentation
`dbt docs serve` -> Serves the documentation on a local web server

