{{ config(materialized='table') }}

with contracts as (
    -- AL Central
    select * from {{ ref('stg_team_contract_guardians') }}
    union all
    select * from {{ ref('stg_team_contract_royals') }}
    union all
    select * from {{ ref('stg_team_contract_tigers') }}
    union all
    select * from {{ ref('stg_team_contract_twins') }}
    union all
    select * from {{ ref('stg_team_contract_white_sox') }}
    -- AL East 
    union all
    select * from {{ ref('stg_team_contract_blue_jays') }}
    union all
    select * from {{ ref('stg_team_contract_orioles') }}
    union all
    select * from {{ ref('stg_team_contract_rays') }}
    union all
    select * from {{ ref('stg_team_contract_redsox') }}
    union all
    select * from {{ ref('stg_team_contract_yankees') }}
    -- AL West
    union all
    select * from {{ ref('stg_team_contract_angels') }}
    union all
    select * from {{ ref('stg_team_contract_athletics') }}
    union all
    select * from {{ ref('stg_team_contract_astros') }}
    union all
    select * from {{ ref('stg_team_contract_rangers') }}
    union all
    select * from {{ ref('stg_team_contract_mariners') }}
    -- NL Central 
    union all
    select * from {{ ref('stg_team_contract_brewers') }}
    union all
    select * from {{ ref('stg_team_contract_cardinals') }}
    union all
    select * from {{ ref('stg_team_contract_cubs') }}
    union all
    select * from {{ ref('stg_team_contract_pirates') }}
    union all
    select * from {{ ref('stg_team_contract_reds') }}
    -- NL East
    union all
    select * from {{ ref('stg_team_contract_braves') }}
    union all
    select * from {{ ref('stg_team_contract_marlins') }}
    union all
    select * from {{ ref('stg_team_contract_mets') }}
    union all
    select * from {{ ref('stg_team_contract_nationals') }}
    union all
    select * from {{ ref('stg_team_contract_phillies') }}
    -- NL West
    union all
    select * from {{ ref('stg_team_contract_dodgers') }}
    union all
    select * from {{ ref('stg_team_contract_diamondbacks') }}
    union all
    select * from {{ ref('stg_team_contract_giants') }}
    union all
    select * from {{ ref('stg_team_contract_padres') }}
    union all
    select * from {{ ref('stg_team_contract_rockies') }}
)

select {{ dbt_utils.generate_surrogate_key(['player_team_name', 'player_name', 'player_age'] ) }}as player_key,
    player_team_name,
    player_name, 
    player_age

from contracts 