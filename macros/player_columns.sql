{% macro player_columns() %}
    name as player_name,
    age as player_age,
    --parse_date('%b %d %y', dob) as player_date_of_birth,
    right(birth, 2) as player_birth_country,
    case 
        when b = 'r' then 'right'
        when b = 'l' then 'left'
        when b = 's' then 'switch'
        when b = 'b' then 'switch'
    end as player_batting_hand,
    case
        when t = 'r' then 'right'
        when t = 'l' then 'left'
    end as player_throwing_hand,
    ht as player_height,
    wt as player_weight,
    case 
        when yrs is null then null 
        else safe_cast(regexp_replace(yrs, r'[^0-9]', '') as int64)  -- clean up years in league
    end as player_years_in_league,
    coalesce(salary, 0) as player_salary  -- replace null with 0
{% endmacro %}