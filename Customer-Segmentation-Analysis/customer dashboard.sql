/*
========================================================================================
Customer Report
========================================================================================
Purpose:
    - This report consolidates key customer metrics and behaviors

Highlights:
    1. Gathers essential fields such as names, ages, and transaction details.
    2. Segments customers into categories (VIP, Regular, New) and age groups.
    3. Aggregates customer-level metrics:
        - total orders
        - total sales
        - total quantity purchased
        - total products
        - lifespan (in months)
    4. Calculates valuable KPIs:
        - recency (months since last order)
        - average order value
        - average monthly spend
========================================================================================
*/

CREATE VIEW [gold.report_customers] as

WITH base_query as (
select c.customer_key,concat(c.first_name,' ',c.last_name) as 'name',c.customer_number,DATEDIFF(year,c.birthdate,GETDATE()) AS 'age',
f.product_key,f.sales_amount,f.order_date,f.order_number ,f.quantity from [gold.fact_sales]f
left join [gold.dim_customers] c 
on c.customer_key=f.customer_key
where f.order_date is not null )

--AGGREGATION QUERY
,aggreagte
as (
select customer_key,
customer_number,
name,
age,
count(DISTINCT order_number) as 'total_orders',
sum(sales_amount) as 'total_sales',
sum(quantity) AS 'total_quantity',
count(distinct product_key) as 'total_products',
MAX(order_date) as 'last_order_date',
CASE 
    WHEN DATEDIFF(month, MIN(order_date), MAX(order_date)) = 0 THEN 1
    ELSE DATEDIFF(month, MIN(order_date), MAX(order_date))
END AS lifespan
from base_query 
group by customer_key,customer_number,name,age)

--final dashboard 
SELECT customer_key,customer_number,name as 'customer_name',age,total_orders,total_sales,total_quantity,lifespan,
CASE 
    WHEN age < 30 then'under_30'
    WHEN age >=30 and age <50 then '30-50'
    Else 'Above_50'
End as 'Age_Categories',
CASE 
        WHEN lifespan >= 12 AND  total_sales> 5000 THEN 'VIP'
        WHEN lifespan >= 12 AND  total_sales <= 5000 THEN 'Regular'
        ELSE 'New'
    END AS customer_segment
,ROUND(CAST(total_sales as float)/total_orders ,2)as 'Average_Order_Value',
ROUND(CAST(total_sales as float)/lifespan,2)as 'Average_monthly_spend',
DATEDIFF(month,last_order_date,GETDATE()) AS 'RECENCY'
FROM aggreagte
where age is not null ;


