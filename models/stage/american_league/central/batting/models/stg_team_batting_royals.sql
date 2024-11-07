{% set columns = ["G" , "PA" , "AB", "R" ,"H", "HR", "RBI", "SB", "CS" , "BB" , "SO" , "BA" , "OBP" , "SLG" , "OPS" 
, "TB" , "GDP" , "HBP" , "SH" , "SF" , "IBB"] %}

with batting as (
    select * from {{ ref('team_batting_royals') }}
)

select 
    
    'Royals' as team
    , Name
    , Rk
    , Pos
    , COALESCE(batting.`2B`, 0) AS `2B`
    , COALESCE(batting.`3B`, 0) AS `3B`

    ,   {% for col in columns %}
            COALESCE({{ col }}, 0) AS {{ col }}{% if not loop.last %}, {% endif %}          -- adds a coalesce function through all remaining metrics
        {% endfor %}

from batting

