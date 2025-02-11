{{config (materialized = 'view',schema ='reporting_dev')}}
 
select distinct emp.country,  cus.companyname, cus.contactname, ord.total_orders,
ord.total_quantity, ord.total_sales, ord.avg_margin
from
{{ ref('dim_customers') }}  cus
 
join (
select distinct customerid,employeeid from {{ ref('fct_orders') }}
) fct_ord
on cus.customerid =  fct_ord.customerid
 
join (
select ord.customerid,
count(ord.orderid) as total_orders,
sum(ord.quantity) as total_quantity,
sum(linesalesamount) as total_sales,
avg(margin) as avg_margin
from {{ ref('fct_orders') }} ord
group by ord.customerid
)ord
on fct_ord.customerid =  ord.customerid
 
join {{ ref('dim_employee') }} emp
on emp.employee_id = fct_ord.employeeid
 
where emp.country = '{{var('v_country','Sweden') }}'
 
order by total_sales desc