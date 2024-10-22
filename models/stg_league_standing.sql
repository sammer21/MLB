with standings as (
    select * from {{ ref('league_standings_2024') }}
)

select * from standings