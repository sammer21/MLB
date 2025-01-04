{{ config(materialized='table') }}

with players as (
    -- AL Central
    select * from {{ ref('stg_guardians_roster') }}
    union all
    select * from {{ ref('stg_royals_roster') }}
    union all
    select * from {{ ref('stg_tigers_roster') }}
    union all
    select * from {{ ref('stg_twins_roster') }}
    union all
    select * from {{ ref('stg_white_sox_roster') }}
    -- AL East 
    union all
    select * from {{ ref('stg_blue_jays_roster') }}
    union all
    select * from {{ ref('stg_orioles_roster') }}
    union all
    select * from {{ ref('stg_rays_roster') }}
    union all
    select * from {{ ref('stg_redsox_roster') }}
    union all
    select * from {{ ref('stg_yankees_roster') }}
    -- AL West
    union all
    select * from {{ ref('stg_angels_roster') }}
    union all
    select * from {{ ref('stg_athletics_roster') }}
    union all
    select * from {{ ref('stg_astros_roster') }}
    union all
    select * from {{ ref('stg_rangers_roster') }}
    union all
    select * from {{ ref('stg_mariners_roster') }}
    -- NL Central 
    union all
    select * from {{ ref('stg_brewers_roster') }}
    union all
    select * from {{ ref('stg_cardinals_roster') }}
    union all
    select * from {{ ref('stg_cubs_roster') }}
    union all
    select * from {{ ref('stg_pirates_roster') }}
    union all
    select * from {{ ref('stg_reds_roster') }}
    -- NL East
    union all
    select * from {{ ref('stg_braves_roster') }}
    union all
    select * from {{ ref('stg_marlins_roster') }}
    union all
    select * from {{ ref('stg_mets_roster') }}
    union all
    select * from {{ ref('stg_nationals_roster') }}
    union all
    select * from {{ ref('stg_phillies_roster') }}
    -- NL West
    union all
    select * from {{ ref('stg_dodgers_roster') }}
    union all
    select * from {{ ref('stg_diamondbacks_roster') }}
    union all
    select * from {{ ref('stg_giants_roster') }}
    union all
    select * from {{ ref('stg_padres_roster') }}
    union all
    select * from {{ ref('stg_rockies_roster') }}
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
