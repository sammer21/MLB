{% set columns = ['W', 'L', 'W-Lpct', 'ERA', 'G', 'GS', 'GF', 'CG', 'SHO', 'SV', 'IP', 'H', 'R', 'ER', 'HR', 
'BB', 'IBB', 'SO', 'HBP', 'BK', 'WP', 'BF', 'ERAplus', 'FIP', 'WHIP', 'H9', 'HR9', 'BB9', 'SO9', 'SO-W']%}

with pitching as (
    select * from {{ ref('team_pitching_orioles') }}
)

select 'Orioles' as player_team_name 
    , Rk as player_rank
    , Name as player_name
    , Pos as player_position
    , cast(coalesce(`Age`, 0) AS INT) as player_age
    , {% for col in columns %}
            coalesce(`{{ col }}`, 0) as `{{ col | lower}}`{% if not loop.last %}, {% endif %}          -- adds a coalesce function through all remaining metrics
        {% endfor %}

from pitching