{{ config(materialized='table') }}

{% set teams = [
    'guardians', 'royals', 'tigers', 'twins', 'white_sox', 'blue_jays', 'orioles', 'rays', 'redsox', 'yankees', 
    'angels', 'athletics', 'astros', 'rangers', 'mariners', 'brewers', 'cardinals', 'cubs', 'pirates', 'reds',     
    'braves', 'marlins', 'mets', 'nationals', 'phillies', 'dodgers', 'diamondbacks', 'giants', 'padres', 'rockies' 
] %}

with contracts as (
    {% for team in teams %}
        {% if not loop.first %}
            union all
        {% endif %}
        select * from {{ ref('stg_team_contract_' ~ team) }}
    {% endfor %}
)

select {{ dbt_utils.generate_surrogate_key(['player_team_name', 'player_name', 'player_age'] ) }}as player_key,
    player_team_name,
    player_name, 
    player_age,
    player_years,
    player_acquired_status,
    player_service_time,
    player_contract_length,
    player_contract_amount,
    player_contract_seasons,
    player_contract_options,
    `2024`,
    `2025`,
    `2026`,
    `2027`,
    `2028`,
    `2029`,
    `2030`
from contracts 