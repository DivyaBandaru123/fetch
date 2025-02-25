Project Summary

This project is an end-to-end data investigation and analysis exercise focused on the Fetch platform. It involved multiple stages:

Data Exploration & Quality Assessment:

Objective: Examine unstructured CSV files (Users, Transactions, Products) to identify data quality issues and ambiguous fields.

Approach: Utilized Python (Pandas, Seaborn, Matplotlib) to load the data, visualize missing values, and review field names.
Findings:
Significant missing values were detected in key fields (e.g., language, barcode, and product category fields).
Ambiguous column names (e.g., CATEGORY_1–CATEGORY_4) necessitate clarification.
Impact: These issues could affect segmentation, reporting, and linking across datasets, making it critical to address data quality for reliable analysis.

SQL Query Analysis:

Objective: Answer both closed-ended and open-ended questions using SQL queries.
Approach:
Closed-ended Examples:
Determined the top 5 brands by receipts scanned among users aged 21 and over.
Identified the top 5 brands by sales for users with accounts older than six months.
Calculated the percentage of sales in the Health & Wellness category by generation.
Open-ended Examples:
Defined "power users" as those in the top 10% of transaction counts.
Determined the leading brand in the Dips & Salsa category based on total sales.
Computed year-over-year sales growth to measure platform expansion.
Assumptions: Clearly stated assumptions regarding field definitions, table relationships, and metrics were made to ensure queries accurately reflect business requirements.
Stakeholder Communication:

Objective: Summarize the data investigation findings in a clear, non-technical manner using the STAR method.

Approach:
Highlighted key data quality issues and ambiguous fields that need further clarification.
Presented an interesting trend: higher engagement (receipt scans) among users aged 21+.
Requested additional documentation on ambiguous fields and guidance on handling missing data to enhance analysis accuracy.
Outcome: A concise email/Slack message was constructed to facilitate further action and collaboration with business leaders.
Version Control & Git Integration:

Objective: Demonstrate proper code and file management using Git.
Approach:
Provided step-by-step Git command instructions to initialize a repository, add files (including SQL files from Visual Studio), commit changes, and push them to GitHub.
Outcome: Ensured all work is tracked and shared via a Git repository, following best practices for version control.

Overall, this project showcases a comprehensive approach to data analysis—from initial exploration and quality assessment to SQL-based insights and 
stakeholder communication—ensuring actionable findings and a robust data foundation for future strategic decisions.
