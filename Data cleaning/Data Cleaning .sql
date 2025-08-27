USE Cafe_data;
GO

/* -------------------------------
   1. Customer Lifespan
--------------------------------*/
SELECT 
    MIN(Transaction_Date) AS First_Order_Date,
    MAX(Transaction_Date) AS Last_Order_Date,
    DATEDIFF(MONTH, MIN(Transaction_Date), MAX(Transaction_Date)) AS Lifespan_Months
FROM dirty_cafe_sales;


/* -------------------------------
   2. Check distinct Item-Price pairs
--------------------------------*/
SELECT DISTINCT 
    Item, 
    Price_Per_Unit
FROM dirty_cafe_sales;


/* -------------------------------
   3. Standardize Item names (based on Price_Per_Unit)
      - Fix NULL Item names
--------------------------------*/
UPDATE dirty_cafe_sales
SET Item = CASE 
              WHEN Price_Per_Unit = 2   THEN 'Coffee'
              WHEN Price_Per_Unit = 1.5 THEN 'Tea'
              WHEN Price_Per_Unit = 1   THEN 'Cookie'
              WHEN Price_Per_Unit = 5   THEN 'Salad'
              ELSE Item
           END
WHERE Item IS NULL;


/* -------------------------------
   4. Standardize Price_Per_Unit
--------------------------------*/
UPDATE dirty_cafe_sales
SET Price_Per_Unit = CASE
                        WHEN Item = 'Coffee'   THEN 2
                        WHEN Item = 'Tea'      THEN 1.5
                        WHEN Item = 'Juice'    THEN 3 
                        WHEN Item = 'Smoothie' THEN 4 
                        WHEN Item = 'Sandwich' THEN 4
                        WHEN Item = 'Salad'    THEN 5
                        WHEN Item = 'Cake'     THEN 3
                        WHEN Item = 'Cookie'   THEN 1 
                        ELSE Price_Per_Unit
                     END;


/* -------------------------------
   5. Item popularity (top ordered items)
--------------------------------*/
SELECT 
    Item, 
    COUNT(*) AS Total_Orders
FROM dirty_cafe_sales
GROUP BY Item
ORDER BY Total_Orders DESC;





/* -------------------------------
   6. Impute missing Quantity with item-level average
--------------------------------*/
WITH AvgQuantity AS (
    SELECT 
        Item, 
        AVG(CAST(Quantity AS FLOAT)) AS AvgQty
    FROM dirty_cafe_sales
    WHERE Quantity IS NOT NULL
    GROUP BY Item
)
UPDATE dcs
SET Quantity = ROUND(aq.AvgQty, 0)
FROM dirty_cafe_sales dcs
JOIN AvgQuantity aq 
  ON dcs.Item = aq.Item
WHERE dcs.Quantity IS NULL;


/* -------------------------------
   7. Compute Total_Spent column
--------------------------------*/
UPDATE dirty_cafe_sales
SET Total_Spent = Quantity * Price_Per_Unit;


/* -------------------------------
   8. Item popularity by Payment & Location
--------------------------------*/
WITH ItemPopularity AS (
    SELECT 
        Item,
        Payment_Method,
        Location,
        COUNT(*) AS Orders,
        ROW_NUMBER() OVER (
            PARTITION BY Item 
            ORDER BY COUNT(*) DESC
        ) AS rn
    FROM dirty_cafe_sales
    WHERE Payment_Method IS NOT NULL  
      AND Location IS NOT NULL
    GROUP BY Item, Payment_Method, Location
)
SELECT 
    Item,
    Payment_Method,
    Location,
    Orders,
    rn
FROM ItemPopularity
ORDER BY Item, Orders DESC;


/* -------------------------------
   9. Final cleanup
--------------------------------*/
-- Remove rows where both Quantity & Price are missing
DELETE FROM dirty_cafe_sales
WHERE Quantity IS NULL 
  AND Price_Per_Unit IS NULL;

-- Replace remaining NULLs with 'Unknown'
UPDATE dirty_cafe_sales
SET Item = COALESCE(Item, 'Unknown'),
    Payment_Method = COALESCE(Payment_Method, 'Unknown'),
    Location = COALESCE(Location, 'Unknown');

-- Final check
SELECT TOP 100 * 
FROM dirty_cafe_sales;
