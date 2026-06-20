{{ config(materialized='view') }}

with cleaned as (

    select
        upper(trim(symbol)) as symbol,
        cast(stock_datetime as timestamp_ntz) as stock_datetime,
        cast(open as number(18,4)) as open_price,
        cast(high as number(18,4)) as high_price,
        cast(low as number(18,4)) as low_price,
        cast(close as number(18,4)) as close_price,
        cast(volume as number) as volume,
        cast(load_timestamp as timestamp_ntz) as load_timestamp

    from {{ source('raw', 'valerio_allan_m3') }}

),

deduped as (

    select *
    from cleaned
    qualify row_number() over (
        partition by symbol, stock_datetime
        order by load_timestamp desc
    ) = 1

)

select *
from deduped