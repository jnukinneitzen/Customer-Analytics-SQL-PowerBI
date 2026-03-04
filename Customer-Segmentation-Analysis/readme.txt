Customer Performance & Sales Analytics

Project Overview:
This project is an end-to-end data analytics solution that extracts actionable insights from raw sales, product, and customer data. Using T-SQL for extensive Exploratory Data Analysis (EDA) and data transformation, and Power BI for visualisation, this project delivers a comprehensive "Customer Performance Executive Summary."

The goal of this project is to track business growth over time, evaluate product performance YoY, and segment customers to identify high-value groups and at-risk accounts.

2. Tech Stack

Database / Query Language: T-SQL (Window Functions, CTEs, Aggregations)

Data Visualisation: Power BI (DAX, Interactive Dashboards)

Data Model: Star Schema (gold.fact_sales, gold.dim_products, gold.dim_customers)

3. Data Sources
The analysis is built on top of three core dimensional tables:

gold.fact_sales: Transactional data including order dates, quantities, and sales amounts.

gold.dim_products: Product catalogue detailing product names, categories, and costs.

gold.dim_customers: Customer demographic data, including names, age categories, and segmentations.

4. SQL Analysis & EDA
The data preparation and exploratory analysis were conducted using advanced T-SQL techniques. Key queries include:

Time Intelligence & Moving Averages: Utilised SUM() OVER and AVG() OVER window functions to calculate running totals for sales and moving average prices by month.

Year-over-Year (YoY) Product Performance: Leveraged Common Table Expressions (CTEs) and the LAG() function to benchmark current product sales against both historical averages and previous year performance.

Category Contribution: Calculated the percentage share of overall sales by product category to identify top revenue drivers.

Customer Report Generation: Consolidated metrics to calculate customer lifespan (in months), recency (months since last order), Average Order Value (AOV), and average monthly spend.

5. Power BI Dashboard
The insights generated from SQL were materialised into a 1-page interactive Power BI dashboard: "CUSTOMER PERFORMANCE EXECUTIVE SUMMARY".

Key Features & KPIs:
High-Level Metrics: Total Sales ($29M), Total Units Sold (28K), AOV ($911.23), and Average Monthly Spend ($452.89).

Revenue Distribution: A doughnut chart breaking down revenue by customer tier (New, VIP, Regular).

Demographic Breakdown: Transaction value analysis comparing different age groups (30-50 vs. above 50).

Loyalty vs. Value: A scatter plot analysing the correlation between customer lifespan and total sales to identify the most valuable, long-term customers.

At-Risk List: A dynamic table highlighting specific customers based on high Recency (days since last purchase) and their historical total sales, allowing for targeted re-engagement campaigns.

