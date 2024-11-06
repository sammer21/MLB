{% set columns = [
    "Name",
    "Age",
    "Birth",
    "B",
    "T",
    "Ht",
    "Wt",
    "Yrs",
    "Salary"
] %}

with roster as (

    select
        {% for col in columns %}
            {{ col }} AS {{ col | lower }}{% if not loop.last %}, {% endif %} -- loop in Jinja to convert column headers to lowercase
        {% endfor %}
    from {{ ref('team_roster_reds') }}

)

select 'Reds' as player_team_name
    , {{ player_columns() }}
from roster