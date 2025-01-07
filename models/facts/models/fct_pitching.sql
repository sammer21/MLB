{{ config(materialized='table') }}

{% set teams = [
    'guardians', 'royals', 'tigers', 'twins', 'white_sox', 'blue_jays', 'orioles', 'rays', 'redsox', 'yankees', 
    'angels', 'athletics', 'astros', 'rangers', 'mariners', 'brewers', 'cardinals', 'cubs', 'pirates', 'reds',     
    'braves', 'marlins', 'mets', 'nationals', 'phillies', 'dodgers', 'diamondbacks', 'giants', 'padres', 'rockies'
] %}

with pitching_data as (
    {% for team in teams %}
        {% if not loop.first %}
            union all 
        {% endif %}
        select {{ dbt_utils.generate_surrogate_key(['player_team_name', 'player_name', 'player_age'] ) }} as player_key,
            *
        from {{ ref('stg_team_pitching_' ~ team)}}
    {% endfor %}
),

contracts as (
    select * from {{ ref('dim_contracts') }}
)




