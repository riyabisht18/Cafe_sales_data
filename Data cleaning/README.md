**Café Sales Data Cleaning & Preparation**

**Project Overview**

This project involved cleaning and preparing a transactional dataset from a café for further exploratory data analysis (EDA). The dataset originally contained missing values, inconsistent records, and ambiguous item-price relationships. The objective was to build a reliable and structured dataset suitable for generating insights into sales performance, customer behavior, and operational efficiency.

**Data Issues Identified**

**Missing Values**: Null entries in Item, Price, Quantity, and Payment Method.

****Inconsistent Records**: Total Spent column did not match Quantity × Price in several cases.

****Ambiguity in Item-Price Mapping****: Items such as Salad and Smoothie shared the same unit price, making item inference difficult when names were missing.

****Null Categorical Fields****: Payment Method and Location had gaps that required treatment.

**Cleaning Process**

**Missing Item & Price Handling** – Cross-checked Item-Price mapping. Where possible, filled missing Item using Price, and vice versa. For ambiguous cases, left as "Unknown".

***Quantity Imputation*** – Replaced missing quantities with item-level averages or modes, ensuring realistic sales values.

**Recalculated Total Spent** – Overwrote inconsistent totals by applying the formula Quantity × Price.

**Categorical Data Treatment**– Filled missing Payment Method and Location with "Unknown" to maintain completeness without biasing results.

**Row Validation**– Removed invalid records where both Quantity and Price were missing.

**Item Popularity Check** – Compared item sales across Price, Location, and Payment Method. Since values were very close across combinations, popularity could not be used reliably for imputations.

**Null Tracking in SQL** – Used SQL queries to measure null counts before and after cleaning to validate improvements.


