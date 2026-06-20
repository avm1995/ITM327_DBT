{{ config(materialized='view') }}

with cleaned as (

    select
        cast(weather_date as date) as weather_date,
        cast(temp_max as number(10,2)) as temp_max,
        cast(temp_min as number(10,2)) as temp_min,
        coalesce(cast(precipitation_sum as number(10,2)), 0) as precipitation_sum,
        cast(load_timestamp as timestamp_ntz) as load_timestamp

    from {{ source('raw', 'valerio_allan_m2') }}

),

deduped as (

    select *
    from cleaned
    qualify row_number() over (
        partition by weather_date
        order by load_timestamp desc
    ) = 1

)

select *
from deduped