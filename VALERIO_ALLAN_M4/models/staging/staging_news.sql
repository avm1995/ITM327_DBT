{{ config(materialized='view') }}

with cleaned as (

    select
        cast("id" as number) as news_id,
        nullif(trim(category), '') as category,
        to_timestamp_ntz(datetime) as news_datetime,
        nullif(trim(headline), '') as headline,
        nullif(trim(image), '') as image_url,
        nullif(trim(related), '') as related_symbol,
        nullif(trim(source), '') as news_source,
        nullif(trim(summary), '') as summary,
        nullif(trim(url), '') as article_url,
        try_to_timestamp_ntz(load_date) as load_timestamp

    from {{ source('raw', 'valerio_allan_m1') }}

),

deduped as (

    select *
    from cleaned
    qualify row_number() over (
        partition by news_id
        order by load_timestamp desc
    ) = 1

)

select *
from deduped