{{config (materialized = 'table',alias = 'stg_empoyees')}}
 
 
select *
from
{{ source('raw_qwt','employee')}}