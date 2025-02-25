
Exercise 1:
1. Are there any data quality issues present?

A: **# *High Missing Value Rates***

In the Users dataset, several critical fields (e.g., LANGUAGE, GENDER, STATE) show a significant number of missing values, which could impede demographic analysis.
In the Transactions dataset, the BARCODE field has a considerable number of missing entries, potentially hindering accurate product tracking.
In the Products dataset, fields such as CATEGORY_3, BRAND, and MANUFACTURER exhibit a high volume of missing data, which may compromise product classification and analysis.

**Inconsistent Data Formatting:**

The visualizations suggest that there might be inconsistent data types (e.g., date formats or numeric fields stored as text) that could lead to errors in downstream processing.

2. Are there any fields that are challenging to understand?

A: **Ambiguous Field Names:**

The Products dataset includes multiple fields labeled as CATEGORY_1, CATEGORY_2, CATEGORY_3, etc., without clear definitions or documentation, making it hard to determine how they differ or should be used.
Some fields (like "user_status" or "engagement_score" if present) may also be unclear in terms of their calculation or intended interpretation.

**Lack of Standard Identifiers:**

Missing or inconsistent BARCODE entries in both Transactions and Products datasets make it challenging to reliably link products across different datasets.

--------------------------------------------------------------------------------------------------------------------
**Exercise: 2**

1. Top 5 Brands by Receipts Scanned Among Users 21 and Over

Assumptions:

The Users table includes an age field and a primary key user_id.
The Transactions table includes a unique receipt_id for each scanned receipt, a user_id to link to Users, and a product_id to link to Products.
The Products table includes a brand field and a primary key product_id.
code: 
SELECT 
    p.brand, 
    COUNT(t.receipt_id) AS receipt_count
FROM Transactions t
JOIN Users u ON t.user_id = u.user_id
JOIN Products p ON t.product_id = p.product_id
WHERE u.age >= 21
GROUP BY p.brand
ORDER BY receipt_count DESC
LIMIT 5;


Top 5 Brands by Sales Among Users with an Account for At Least Six Months

Assumptions:

The Users table includes an account_age field (in months) and a primary key user_id.
The Transactions table includes a sale_amount field representing the sale value, a user_id field, and a product_id field.
The Products table includes a brand field.
sql
Copy
SELECT 
    p.brand, 
    SUM(t.sale_amount) AS total_sales
FROM Transactions t
JOIN Users u ON t.user_id = u.user_id
JOIN Products p ON t.product_id = p.product_id
WHERE u.account_age >= 6
GROUP BY p.brand
ORDER BY total_sales DESC
LIMIT 5;

3. Percentage of Sales in the Health & Wellness Category by Generation

Assumptions:

The Users table includes a generation field (to segment users by generation) and a primary key user_id.
The Transactions table includes a sale_amount field, a user_id field, and a product_id field.
The Products table includes a category field, where one of the categories is 'Health & Wellness'.
sql
Copy
SELECT 
    u.generation,
    ROUND(
      100.0 * SUM(CASE WHEN p.category = 'Health & Wellness' THEN t.sale_amount ELSE 0 END) / SUM(t.sale_amount),
      2
    ) AS health_wellness_percentage
FROM Transactions t
JOIN Users u ON t.user_id = u.user_id
JOIN Products p ON t.product_id = p.product_id
GROUP BY u.generation;


open-ended:

 1. Who Are Fetch’s Power Users?
Assumptions:

The Transactions table records each user’s activity (one row per transaction).
“Power users” are defined as the top 10% of users by the total number of transactions.
The primary key linking transactions to users is user_id.
sql
Copy
WITH UserActivity AS (
    SELECT 
        user_id, 
        COUNT(*) AS total_transactions
    FROM Transactions
    GROUP BY user_id
),
PowerThreshold AS (
    SELECT 
        PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY total_transactions) AS threshold
    FROM UserActivity
)
SELECT 
    ua.user_id, 
    ua.total_transactions
FROM UserActivity ua
JOIN PowerThreshold pt ON ua.total_transactions >= pt.threshold
ORDER BY ua.total_transactions DESC;

2. Which is the Leading Brand in the Dips & Salsa Category?
Assumptions:

The Products table includes a category field where one of the values is 'Dips & Salsa'.
The Transactions table has a sale_amount field representing the sales value.
The Products table includes a brand field, and transactions are linked to products via product_id.
“Leading brand” is defined by the highest total sales within the Dips & Salsa category.
sql
Copy
SELECT 
    p.brand, 
    SUM(t.sale_amount) AS total_sales
FROM Transactions t
JOIN Products p ON t.product_id = p.product_id
WHERE p.category = 'Dips & Salsa'
GROUP BY p.brand
ORDER BY total_sales DESC
LIMIT 1;

3. At What Percent Has Fetch Grown Year Over Year?
Assumptions:

The Transactions table contains a transaction_date field (of type DATE or TIMESTAMP).
Sales growth is measured using the sum of sale_amount per year.
Year-over-year growth is calculated as the percentage increase (or decrease) from one year’s total sales to the next.
sql
Copy
WITH YearlySales AS (
    SELECT 
        EXTRACT(YEAR FROM transaction_date) AS year,
        SUM(sale_amount) AS total_sales
    FROM Transactions
    GROUP BY EXTRACT(YEAR FROM transaction_date)
),
YearlyGrowth AS (
    SELECT 
        ys.year,
        ys.total_sales,
        LAG(ys.total_sales) OVER (ORDER BY ys.year) AS previous_year_sales
    FROM YearlySales ys
)
SELECT 
    year,
    ROUND(100.0 * (total_sales - previous_year_sales) / previous_year_sales, 2) AS growth_percentage
FROM YearlyGrowth
WHERE previous_year_sales IS NOT NULL;



----------------------------------------------------------------------------------------------------------------------------------

**Exercise-3**

Subject: Data Investigation Summary & Request for Additional Details

Hi [Stakeholder],

I wanted to share a brief summary of our recent data investigation for the Fetch project and request some additional details to help refine our analysis:

Key Data Quality Issues:

Missing Values:
Several critical fields (e.g., LANGUAGE in Users, BARCODE in Transactions and Products) have significant missing entries, which could affect segmentation and accurate mapping of products.

Ambiguous Field Names:
In the Products dataset, columns labeled as CATEGORY_1, CATEGORY_2, etc., are unclear in their hierarchy and meaning. Clarification on these fields would help ensure we’re analyzing product classifications correctly.

Inconsistent Formatting:
Some fields (like date or numeric fields) appear to have inconsistent formatting, which might lead to errors in aggregations or trend analysis.

Outstanding Questions:
Can you provide documentation or definitions for ambiguous fields, especially those in the Products dataset (e.g., CATEGORY_1–CATEGORY_4)?
Is there a preferred method for handling missing values in key fields (e.g., should we impute data, exclude incomplete records, etc.)?
Are there any specific data quality fixes already in progress that we should be aware of?

Interesting Trend: Our analysis revealed that users aged 21 and over are generating a significantly higher number of receipt scans. 
This suggests that this demographic may be a key driver for our product engagement, offering a potential focus area for targeted marketing initiatives.

Next Steps & Request for Action:

Documentation: Any additional details or documentation regarding ambiguous fields would be highly appreciated.
Guidance on Data Handling: Please advise if there are specific strategies we should use for handling missing or inconsistent data.
Feedback: I welcome any feedback on our analysis approach to ensure our findings align with broader business objectives.
Thank you for your time and assistance. I look forward to your insights so we can continue to improve our data quality and analysis.

Best regards,
Divya Bandaru.