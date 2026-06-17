USE WAREHOUSE animal_task_wh;
SHOW TABLES IN DATABASE tasty_bytes_dbt_db;

SHOW VIEWS IN DATABASE tasty_bytes_dbt_db;

-- Query to run DBT PROJECT Deploy
CREATE DBT PROJECT "TASTY_BYTES_DBT_DB"."DEV"."TASTY_BYTES_DBT_PROJECT" FROM $$snow://workspace/USER$BISON.PUBLIC."getting-started-with-dbt-on-snowflake"/versions/live/tasty_bytes_dbt_demo$$ DEFAULT_TARGET = 'dev' EXTERNAL_ACCESS_INTEGRATIONS = ('DBT_EXT_ACCESS');

SHOW DBT PROJECTS LIKE 'tasty%';

SHOW WAREHOUSES;


CREATE OR REPLACE SECRET my_git_secret
  TYPE = password
  USERNAME = 'NicholasBoss'
  PASSWORD = '';

  CREATE OR REPLACE API INTEGRATION my_git_api
  API_PROVIDER = git_https_api
  API_ALLOWED_PREFIXES = ('https://github.com/')
  ALLOWED_AUTHENTICATION_SECRETS = (my_git_secret)
  ENABLED = TRUE;

  CREATE OR REPLACE GIT REPOSITORY snowflake_dbt_demo
  ORIGIN = 'https://github.com/NicholasBoss/getting-started-with-dbt-on-snowflake'
  API_INTEGRATION = my_git_api
  GIT_CREDENTIALS = my_git_secret;