📊 Cafe Data Analysis – EDA Project
🔹 Project Overview
This project analyzes 11 months of cafe sales data to uncover patterns in revenue, item performance, and customer behavior. The dataset was cleaned in SQL and later explored for insights.

🔹 Key Insights
Overall Performance


Total Sales (Revenue): $88,546


Total Quantity Sold: 13,018 items


Average Order Value (AOV): $8.92


Top & Bottom Items


Top-selling items by sales: 🥗 Salad & 🥪 Sandwich


Bottom-selling item: 🍪 Cookie (only 3,596 sold)


Premium items: Salad & Smoothie priced at $4–$5, making them the most expensive menu items.


Sales by Location


Unknown: 39% (data issue → could not identify location)


Takeaway: 29%


In-store: 30%


Customer Preferences


The core 3 items (Salad, Sandwich, Smoothie) contribute the majority of sales.


Weekdays generate $60,179 revenue, much higher than weekends $24,244 → suggests strong demand from office workers or regular weekday visitors.

🔑 Observation (about duplicates):
Sandwich ($4) and Smoothie ($4) share the same price.


Cake ($3) and Juice ($3) share the same price.


So if an order is missing the item name but only has the price, we can’t be sure whether:
$4 → Sandwich or Smoothie


$3 → Cake or Juice



📉 Impact on Revenue Analysis:
Total revenue (all items combined) is correct 


But item-level revenue (like “Which item sold most?”) is uncertain  because we don’t know which of the $3 or $4 sales belong to which product.



 This means Cake might be the top seller OR Juice could be. Same with Sandwich vs Smoothie.
