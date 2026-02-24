***Café Sales Analytics** – End-to-End Data Project
🎯 Goal
Turn messy café sales data into clear business insights for better decisions on menu, staffing, and promotions.

🔍 **The Problem**
The data was too messy to trust:

Missing items, prices, and quantities

Wrong totals (Total ≠ Quantity × Price)

Same price for different items (e.g., $4 = Sandwich OR Smoothie)

Blank customer info (payment, location)

🛠️ **What I Did**
1. Data Cleaning (SQL)
Fixed the mess systematically:

Matched items to prices using café menu rules

Recalculated all totals: Total = Quantity × Price

Filled missing quantities with item-specific averages (not guessing)

Labeled unknowns as "Unknown" instead of deleting data

Removed only unusable records (<2% of data)

Avg Order Value: $8.92

Top Sellers: 🥗 Salad & 🥪 Sandwich (premium $4-$5 items)

Big Discovery: Weekdays make 71% more money than weekends ($60K vs $24K)

Sales Channels: 30% in-store, 30% takeaway, 40% unknown (data gap!)

3. **Dashboard (Tableau)**
Built interactive views showing:

Revenue trends by day, month, and item

Side-by-side weekday vs. weekend performance

Top item rankings by revenue and quantity

Sales channel breakdown

📈 **Business Impact**
Immediate actions taken:

Menu focus: Push Salad & Sandwich (high margin)

Staffing: Increase weekday shifts to match peak sales

Promotions: Create weekend specials to boost off-peak revenue

Data fix: Improve point-of-sale to capture location data
____________________________________________________________________________________________________________________________________________________________________
 ![Image Alt](https://github.com/riyabisht18/Cafe_sales_data/blob/1b975640fa0178c2d95e24a031b604d41001531a/Cafe%20Sales%20Dashboard.png).







