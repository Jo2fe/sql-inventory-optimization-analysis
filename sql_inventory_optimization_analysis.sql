---SQL CAPSTONE PROJECT
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
