{% set columns = ['Age', 'W', 'L', 'ERA', 'G', 'GS', 'GF', 'CG', 'SHO', 'SV', 'IP', 'H', 'R', 'ER', 'HR', 
'BB', 'IBB', 'SO', 'HBP', 'BK', 'WP', 'BF', 'ERAplus', 'FIP', 'WHIP', 'H9', 'HR9', 'BB9', 'SO9', 'SO-W']%}

with pitching as (
    select * from {{ ref('team_pitching_cardinals') }}
)

select 'Cardinals' as Team 
    , Rk
    , Name
    , Pos 
    , {% for col in columns %}
            coalesce(`{{ col }}`, 0) as `{{ col }}`{% if not loop.last %}, {% endif %}          -- adds a coalesce function through all remaining metrics
        {% endfor %}
    , coalesce(`W-L%`, 0) as `W-Lpct`

from pitching