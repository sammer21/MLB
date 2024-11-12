{% set columns = ['Age', 'W', 'L', 'W-Lpct', 'ERA', 'G', 'GS', 'GF', 'CG', 'SHO', 'SV', 'IP', 'H', 'R', 'ER', 'HR', 
'BB', 'IBB', 'SO', 'HBP', 'BK', 'WP', 'BF', 'ERAplus', 'FIP', 'WHIP', 'H9', 'HR9', 'BB9', 'SO9', 'SO-W']%}

with pitching as (
    select * from {{ ref('team_pitching_astros') }}
)

select 'Astros' as Team 
    , Rk
    , Name
    , Pos 
    , {% for col in columns %}
            coalesce(`{{ col }}`, 0) as `{{ col }}`{% if not loop.last %}, {% endif %}          -- adds a coalesce function through all remaining metrics
        {% endfor %}

from pitching