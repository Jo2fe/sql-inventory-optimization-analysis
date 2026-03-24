sql-inventory-optimization-analysis

README.md
inventory_analysis.sql

---TASKS
--a) What is the total number of units sold per product SKU?
SELECT productid, SUM(inventoryquantity) AS Total_Units_Sold
FROM sales
GROUP BY productid
ORDER BY Total_Units_Sold DESC;

---b) Which product category had the highest sales volume last month?
SELECT productcategory, SUM(inventoryquantity) AS Sales_Volume
FROM sales s
JOIN product p on p.productid = s.productid
WHERE s.sales_year = '2021' AND s.sales_month = '11'
GROUP BY productcategory
ORDER BY Sales_Volume DESC
LIMIT 1;

----c) How does the inflation rate correlate with sales volume for a specific month?
SELECT s.sales_month, s.sales_year, AVG(f.inflationrate) AS Avg_Inflationrate, 
SUM(s.inventoryquantity) AS Sales_Volume
FROM sales s
JOIN factors f on s.salesdate = f.salesdate
GROUP BY sales_year, sales_month;


---d) What is the correlation between the inflation rate and sales quantity for all products combined on a
---monthly basis over the last year?
SELECT s.sales_month, s.sales_year, AVG(f.inflationrate) AS Avg_Inflationrate, 
SUM(s.inventoryquantity) AS Sales_Quantity
FROM sales s
JOIN factors f on s.salesdate = f.salesdate
WHERE s.salesdate >= (CURRENT_DATE - INTERVAL '1 Year')
GROUP BY sales_year, sales_month
ORDER BY sales_year, sales_month;

---e)Did promotions significantly impact the sales quantity of products?
SELECT p.productcategory, ROUND(AVG(s.inventoryquantity)) AS Avg_Sales_Without_Promotion, p.promotions
FROM sales s
JOIN product p on s.productid = p.productid
WHERE p.promotions = 'No'
GROUP BY p.productcategory, p.promotions

UNION ALL


SELECT p.productcategory, ROUND(AVG(s.inventoryquantity)) AS Avg_Sales_With_Promotion, p.promotions
FROM sales s
JOIN product p on s.productid = p.productid
WHERE p.promotions = 'Yes'
GROUP BY p.productcategory, p.promotions;


----f) What is the average sales quantity per product category?
SELECT p.productcategory, ROUND(AVG(s.inventoryquantity)) AS Avg_Sales
FROM sales s
JOIN product p on s.productid = p.productid
GROUP BY productcategory
ORDER BY Avg_Sales DESC;


----g) How does the GDP affect the total sales volume?
SELECT sales_year, SUM(f.gdp) AS Total_GDP, SUM(s.inventoryquantity) AS Total_Sales
FROM sales s
JOIN factors f on f.salesdate = s.salesdate
GROUP BY s.sales_year
ORDER BY Total_Sales DESC;


---h) What are the top 10 best-selling product SKUs?
SELECT productid, SUM(inventoryquantity) AS Units_Sold
FROM sales 
GROUP BY productid
ORDER BY Units_Sold DESC
LIMIT 10;


---i) How do seasonal factors influence sales quantities for different product categories?
SELECT p.productcategory, ROUND(AVG(f.seasonalfactor), 4) AS Avg_Seasonal_Factors, 
SUM(s.inventoryquantity) AS Total_Sales
FROM sales s
JOIN product p on s.productid = p.productid
JOIN factors f on s.salesdate = f.salesdate
GROUP BY productcategory
ORDER BY Avg_Seasonal_Factors;


---j) What is the average sales quantity per product category, and how many products within each
---category were part of a promotion?
SELECT p.productcategory, ROUND(AVG(s.inventoryquantity)) AS Avg_Sales_Quantity, 
COUNT(CASE WHEN p.promotions = 'Yes' THEN 1 END) AS Promotion_Count
FROM sales s
JOIN product p on s.productid = p.productid
GROUP BY p.productcategory
ORDER BY Avg_Sales_Quantity;


/data
dataset.csv
<img width="1386" height="259" alt="quest 4" src="https://github.com/user-attachments/assets/8ddaac16-cc0c-418a-adef-ce111c030e67" />
<img width="1386" height="228" alt="quest 3" src="https://github.com/user-attachments/assets/659dde03-4450-4e88-aa5b-eed2fce914af" />
<img width="1386" height="228" alt="quest 2" src="https://github.com/user-attachments/assets/68159a9e-275f-4250-8c71-23e475b3f295" />


Documentation

Inventory Optimization Analysis Using SQL
Data-Driven Supply Chain Insights for T.T. Inc.
Project Overview

This project analyzes inventory performance, product demand, and sales trends for T.T. Inc., a consumer electronics and home appliances distributor. The objective was to identify inventory inefficiencies and provide data-driven recommendations to improve product availability, reduce overstock risk, and support operational decision-making.

Using SQL and PostgreSQL, I analyzed sales records, product attributes, and external economic factors across a 5-year period to identify demand drivers and operational improvement opportunities.

Business Problem

T.T. Inc. faced operational challenges caused by inconsistent inventory management:

Overstocking slow-moving products
Stockouts of high-demand SKUs
Lack of data-driven inventory decisions
Limited visibility into category performance

These issues created both revenue risk and unnecessary carrying costs.

The goal of this project was to replace intuition-based inventory decisions with data-driven insights.

Data & Tools Used
Tools
SQL
PostgreSQL
pgAdmin
Relational database analysis
Dataset Structure

The analysis used three relational tables:

Sales table

Product ID
Quantity sold
Sales date

Product table

Product category
Promotion indicators

Factors table

GDP
Inflation rate
Seasonal factors

This structure allowed correlation analysis between product performance and external economic indicators.

Analytical Approach

The project addressed 10 key business questions including:

Which SKUs generate the most sales?
Which categories present inventory risk?
Do promotions significantly affect demand?
Do macroeconomic factors impact purchasing behavior?
Which products should be prioritized?

SQL techniques applied included:

INNER JOIN for multi-table analysis
GROUP BY for category aggregation
ORDER BY for ranking performance
Aggregate functions (SUM, AVG)
UNION ALL for comparative analysis
CASE WHEN conditional logic
Date filtering for trend analysis

These techniques enabled structured business intelligence analysis.

Key Insights
Electronics category drives highest demand

Electronics generated the highest sales volume and strongest demand among all categories.

Business impact:
Inventory shortages in this category likely result in missed revenue opportunities.

Top SKUs drive disproportionate revenue

Analysis identified the top 10 SKUs as the primary sales drivers.

Business impact:
Ensuring consistent availability of these SKUs represents the highest inventory ROI opportunity.

Promotions showed minimal sales impact

Promotional activity did not significantly increase average sales quantities.

Business impact:
This suggests promotional effectiveness may depend more on targeting than spending levels.

Macroeconomic factors showed limited correlation

GDP and inflation showed little relationship with sales performance.

Business impact:
Inventory decisions should prioritize internal sales metrics rather than external economic indicators.

Demand showed minimal seasonality

Sales patterns indicated stable purchasing behavior across time periods.

Business impact:
Consistent inventory strategies may be more effective than seasonal adjustments.

Business Recommendations

Based on the analysis, the following actions were recommended:

Inventory Optimization
Increase safety stock for high-demand electronics products
Implement SKU-level restocking thresholds
Monitor inventory turnover metrics
Revenue Optimization
Prioritize availability of top-performing SKUs
Reduce excess stock in low-performing categories
Marketing Strategy
Reevaluate promotional targeting
Focus promotions on high-conversion segments
Operational KPIs

Focus monitoring on:

Sell-through rate
Days inventory outstanding
Stockout frequency
Restock lead times

These actions could improve inventory efficiency and reduce revenue loss.

Project Impact

This project demonstrates the ability to:

Extract insights from relational datasets
Apply SQL to real business problems
Identify operational inefficiencies
Translate technical analysis into business recommendations
Support supply chain decisions with data
Technical Skills Demonstrated
SQL Skills
Joins
Aggregations
Ranking queries
Conditional logic
UNION operations
Date filtering
Analytics Skills
KPI analysis
Trend analysis
Inventory optimization
Business intelligence reporting
Data interpretation
Business Skills
Data storytelling
Problem solving
Decision support analysis
Business recommendations
