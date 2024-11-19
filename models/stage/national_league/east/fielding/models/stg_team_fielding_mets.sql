{%set columns = ["G", "GS", "CG", "Inn", "Ch", "A", "E", "DP", "Fldpct", "Rtot", "Rtot-yr", "Rdrs", "Rdrs-yr", "Rgood", "RF-9"
, "RF-G", "PB", "WP", "SB", "CS", "CSpct", "lgCSpct"] %}

with fielding as (
    select * from {{ ref('team_fielding_mets') }}
)

select 'Mets' as Team 
    , cast(Age as int) as Age
    , {% for col in columns %}
            coalesce(`{{ col }}`, 0) as `{{ col }}`{% if not loop.last %}, {% endif %}          -- adds a coalesce function through all remaining metrics
        {% endfor %}
    
    , coalesce(PO, 0) as PutOuts
    , coalesce(PO_2, 0) as Pickoffs
    , `Pos-Summary`
from fielding