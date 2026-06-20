version: 2

models:
  - name: stg_news
    columns:
      - name: news_id
        data_tests:
          - not_null
          - unique

  - name: stg_stocks
    data_tests:
      - dbt_utils.unique_combination_of_columns:
          combination_of_columns:
            - symbol
            - stock_datetime
    columns:
      - name: symbol
        data_tests:
          - not_null
      - name: stock_datetime
        data_tests:
          - not_null

  - name: stg_weather
    data_tests:
      - dbt_utils.unique_combination_of_columns:
          combination_of_columns:
            - weather_date
            - load_timestamp
    columns:
      - name: weather_date
        data_tests:
          - not_null
      - name: load_timestamp
        data_tests:
          - not_null