USE Cafe_data

------------------------------------------------------------
-- 1.  DISTINCT ITEMS & PRICES
-- View all unique items with their corresponding prices
------------------------------------------------------------
SELECT DISTINCT 
    Item, Price_Per_Unit
FROM cafe_Sales_data 
ORDER BY Price_Per_Unit DESC; 


------------------------------------------------------------
-- 2. OVERALL METRICS
-- Total revenue, total quantity sold, and avg order value
------------------------------------------------------------
SELECT 
    SUM(Total_Spent) AS Total_revenue,
    SUM(Quantity) AS Quantity_sold,
    AVG(Total_Spent) AS AVG_order_value
FROM cafe_Sales_data ; 


------------------------------------------------------------
-- 3. SALES BY ITEM
-- Total revenue and total quantity per item
------------------------------------------------------------
SELECT 
    Item, 
    SUM(Total_Spent) AS Total_revenue,
    SUM(Quantity) AS Total_quantity 
FROM cafe_Sales_data 
GROUP BY Item
ORDER BY Total_revenue DESC; 


------------------------------------------------------------
-- 4. SALES BY LOCATION
-- Revenue share and total sales by in-store vs takeaway
------------------------------------------------------------
SELECT 
    Location,
    SUM(Total_Spent) AS Total_salesbylocation,
    ROUND(SUM(Total_Spent) * 100.0 / SUM(SUM(Total_Spent)) OVER(), 2) AS Sales_Share
FROM cafe_Sales_data 
GROUP BY Location
ORDER BY Total_salesbylocation DESC; 


------------------------------------------------------------
-- 5. SALES BY PAYMENT METHOD
-- Compare revenue contribution from different payment methods
------------------------------------------------------------
SELECT 
    Payment_Method,
    SUM(Total_Spent) AS Total_sales
FROM cafe_Sales_data 
GROUP BY Payment_Method
ORDER BY Total_sales DESC; 


------------------------------------------------------------
-- 6. TOP 2 SELLING ITEMS
-- Identify best-selling items based on total sales
------------------------------------------------------------
SELECT TOP 3
    Item,
    SUM(Total_Spent) AS Total_sales
FROM cafe_Sales_data 
GROUP BY Item
ORDER BY Total_sales DESC; 


------------------------------------------------------------
-- 7. ITEM-WISE REVENUE % SHARE
-- Calculate each item's contribution to total revenue
------------------------------------------------------------
SELECT 
    Item,
    Total_sales,
    SUM(Total_sales) OVER() AS Overall_sales,
    ROUND(CAST(Total_sales AS float) / SUM(Total_sales) OVER() * 100, 2) AS Revenue_Percentage
FROM (
    SELECT 
        Item,
        SUM(Total_Spent) AS Total_sales
    FROM cafe_Sales_data 
    GROUP BY Item
) t
GROUP BY Item, Total_sales
ORDER BY Revenue_Percentage DESC; 


------------------------------------------------------------
-- 8. MONTHLY SALES TREND
-- Total sales grouped by month for seasonal trend analysis
------------------------------------------------------------
SELECT 
    FORMAT(DATETRUNC(MONTH, Transaction_Date), 'MMM') AS Month,
    SUM(Total_Spent) AS Monthly_Sales
FROM cafe_Sales_data 
GROUP BY FORMAT(DATETRUNC(MONTH, Transaction_Date), 'MMM')
ORDER BY Monthly_Sales DESC; 


------------------------------------------------------------
-- 9. WEEKDAY VS WEEKEND SALES
-- Compare sales between weekdays and weekends
------------------------------------------------------------
SELECT  
    CASE  
        WHEN DATENAME(WEEKDAY, Transaction_Date) IN ('Saturday', 'Sunday') THEN 'Weekend'  
        ELSE 'Weekday'  
    END AS Day_Type,  
    SUM(Total_Spent) AS Total_Revenue,  
    SUM(Quantity) AS Total_Quantity  
FROM cafe_Sales_data 
WHERE Transaction_Date IS NOT NULL  
GROUP BY CASE  
        WHEN DATENAME(WEEKDAY, Transaction_Date) IN ('Saturday', 'Sunday') THEN 'Weekend'  
        ELSE 'Weekday'  
    END  
ORDER BY Total_Revenue DESC; 


