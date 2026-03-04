--change over time
select order_date,total_sales,
sum(total_sales) over(partition by order_date order by order_date) as "running_total"
,avg(avg_price) over(order by order_date) as "moving_average_price"
from(
SELECT datetrunc(month,order_date) as "order_date",sum(sales_amount) as "total_sales",count(distinct customer_key) as "total_customers",sum(quantity) as "total_quantity"
,avg(price) as "avg_price"
from  [gold.fact_sales]
where order_date is not null
group by datetrunc(month,order_date)
)t;


--performance analysis

--analyse the yearly performance of products by comparing their sales to both the average sales and previous year sales





With yearly_product_sales AS (
select year(f.order_date) as "order_year",p.product_name,sum(f.sales_amount) as "current_sales"
from [gold.fact_sales] f
left join [gold.dim_products]p
on f.product_key=p.product_key
where f.order_date is not null
group by 
year(f.order_date),p.product_name
)
select
*,avg(current_sales) over(partition by product_name) as "avg_sales"
,current_sales - avg(current_sales) over(partition by product_name) as "diff_avg",
CASE WHEN current_sales - avg(current_sales) over(partition by product_name) >0 then 'above_avg'
	WHEN current_sales - avg(current_sales) over(partition by product_name)=0 then 'avg'
	ELSE 'below_avg'
END avg_change,
LAG(current_sales) over(partition by product_name order by order_year) as 'previous_year',
current_sales -LAG(current_sales) over(partition by product_name order by order_year) as 'previous_year_diff',
CASE WHEN current_sales - LAG(current_sales) over(partition by product_name order by order_year) >0 then 'more_than_prev_year'
	 WHEN current_sales - LAG(current_sales) over(partition by product_name order by order_year) <0 then 'less_as prev_year'
	 ELSE 'same_as_prev_year'
END prev_year_change
from yearly_product_sales
order by product_name , order_year;


--which category contribute the most to overall sales?

SELECT p.category,concat(round((cast(sum(f.sales_amount) as float)/sum(sum(f.sales_amount)) over())*100,2),'%') as "percent_share"
FROM [gold.fact_sales] as f
LEFT JOIN [gold.dim_products] p
on p.product_key=f.product_key
where p.category is not null and f.sales_amount is not null
group by p.category


--segmentation 

--segment product into cost ranges and count how many products fall into each segment


select product_key,product_name,cost
from [gold.dim_products]

















