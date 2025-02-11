{{ config(materialized = 'table') }}
 
select
OrderID ,
LineNo ,
ShipperID ,
CustomerID,
ProductID ,
EmployeeID ,
TO_DATE(substring(ShipmentDate,1,9)) as ShipmentDate,
Status
from
{{ source('raw_qwt','Shipments')}}