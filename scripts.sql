-- 1

USE mydb;

select 
od.*,
(select customer_id from orders where id = od.order_id) as customer_id
from order_details od


-- 2

USE mydb;

select 
od.*
from order_details od
where order_id in (select id from orders where shipper_id=3)


-- 3

USE mydb;

select
od.order_id,
avg(od.quantity) as avg_quantity
from (select * from order_details where quantity>10) od
group by 1


-- 4

USE mydb;

with temp as (
	select 
    * 
    from order_details 
    where quantity>10
    )
select
order_id,
avg(quantity) as avg_quantity
from temp
group by 1


-- 5

USE mydb;

DROP FUNCTION IF EXISTS TempFunction;

DELIMITER //

CREATE FUNCTION TempFunction(parameter_1 FLOAT, parameter_2 FLOAT)
RETURNS FLOAT
DETERMINISTIC 
NO SQL
BEGIN
    DECLARE result FLOAT;
    SET result = parameter_1 / parameter_2;
    RETURN result;
END //

DELIMITER ;

SELECT 
quantity as orig_quantity,
TempFunction(quantity, 2) as result
from order_details