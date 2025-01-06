with contract_data as (
    select * 
    from {{ ref('team_contracts_twins') }}
    where Name is not null 
),

contract_amount as (
    select 
        Name, 
        case when instr(`Contract-Status`, '$') > 0 AND instr(`Contract-Status`, '(') > 0 
            THEN TRIM(REPLACE(REPLACE(SUBSTR(`Contract-Status`, instr(`Contract-Status`, '$') + 1, instr(`Contract-Status`, '(') - instr(`Contract-Status`, '$') - 1), 'k', ''), 'M', ''))
        end as Contract_Numeric_Amount,
    case when regexp_contains(`Contract-Status`, r'[kKmM]') 
         then regexp_extract(`Contract-Status`, r'[kKmM]')
         else null
    end as Contract_Amount_Measure
    from contract_data
)


select 'Twins' as player_team_name, 
    contract_data.Name as player_name, 
    Age as player_age,
    Yrs as player_years, 
    Acquired as player_acquired_status,
    SrvTm as player_service_time,
    Agent as player_agent, 
    regexp_extract(`Contract-Status`, r'\d+ yr[s]?') as player_contract_length,
    case when contract_amount.Contract_Amount_Measure = 'k' then cast(contract_amount.Contract_Numeric_Amount as FLOAT64)*1000
         when contract_amount.Contract_Amount_Measure = 'M' then cast(contract_amount.Contract_Numeric_Amount as FLOAT64) *1000000
         else cast(contract_amount.Contract_Numeric_Amount as FLOAT64)
    end as player_contract_amount,
    regexp_extract(`Contract-Status`, r'\((\d{2}(?:-\d{2})?)\)') as player_contract_seasons,
    regexp_extract(`Contract-Status`, r'& (.+)$') as player_contract_options,
    `2024`,
    `2025`,
    `2026`,
    `2027`,
    `2028`,
    `2029`,
    `2030`
from contract_data
left join contract_amount
    on contract_data.Name = contract_amount.Name


