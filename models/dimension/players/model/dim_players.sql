{{ config(materialized='table') }}

{% set teams = [
    'guardians', 'royals', 'tigers', 'twins', 'white_sox', 'blue_jays', 'orioles', 'rays', 'redsox', 'yankees', 
    'angels', 'athletics', 'astros', 'rangers', 'mariners', 'brewers', 'cardinals', 'cubs', 'pirates', 'reds',     
    'braves', 'marlins', 'mets', 'nationals', 'phillies', 'dodgers', 'diamondbacks', 'giants', 'padres', 'rockies' 
] %}

with players as (
    {% for team in teams %}
        {% if not loop.first %}
            union all
        {% endif %}
        select * from {{ ref('stg_' ~ team ~ '_roster') }}
    {% endfor %}
)

select {{ dbt_utils.generate_surrogate_key(['player_team_name', 'player_name', 'player_age'] ) }}as player_key,
    player_team_name,
    player_name, 
    player_age, 
    player_birth_country,
    player_batting_hand,
    player_throwing_hand,
    player_height,
    player_weight,
    player_years_in_league,
    player_salary
from players
