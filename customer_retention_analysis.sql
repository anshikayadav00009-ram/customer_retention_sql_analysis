#  Creat database for the project
CREATE DATABASE customer_retention_analysis;
#  Use the database
USE customer_retention_analysis;
#  Then import CSv using TABLE_DATA_IMPORT_WIZARD

#View first few rows
SELECT * FROM customer_data
limit 10;

#  check table structure 

DESCRIBE customer_data;

#  Count total customers
SELECT COUNT(*) FROM customer_data;
SELECT DISTINCT CHURN FROM customer_data;

#Check for missing values

SELECT *
FROM customer_data
WHERE customer_id IS NULL
   OR tenure IS NULL
   OR monthly_charges IS NULL
   OR total_charges IS NULL
   OR contract IS NULL
   OR payment_method IS NULL
   OR internet_service IS NULL
   OR tech_support IS NULL
   OR online_security IS NULL
   OR support_calls IS NULL
   OR churn IS NULL;
   
   # Check duplicate customer_id
   
   SELECT customer_id, COUNT(*)
FROM customer_data
GROUP BY customer_id
HAVING COUNT(*) > 1;

# churn distribution
# How many customers churned vs stayed?
-- Count customers by churn status
SELECT churn, COUNT(*) AS customer_count
FROM customer_data
GROUP BY churn;

#6843 customers have churned and 13157 customers stayed. 

# What percentage of customers churned?
-- Churn rate: percentage of customers who churned
SELECT 
    COUNT(CASE WHEN churn = 'Yes' THEN 1 END) * 100.0 / COUNT(*) AS churn_rate_percentage
FROM customer_data;
# OBSERVATION: Approximately 34% customers have churned that is quite high.

-- Churn distribution based on contract type
SELECT contract, churn, COUNT(*) AS total_customers
FROM customer_data
GROUP BY contract, churn;
#Observation:

# Month-to-month contracts have higher churn → short-term customers are more likely to leave Long-term contracts have lower churn → longer contracts improve retention

# Which internet service has higher churn rate?
-- Churn distribution based on internet service
SELECT internet_service, churn, COUNT(*) AS total_customers
FROM customer_data
GROUP BY internet_service, churn;
#Observation:
#Customers with Fiber churn more than DSL. 


-- Does having tech support affect churn?

-- Count churn based on tech support availability
SELECT tech_support, churn, COUNT(*) AS total_customers
FROM customer_data
GROUP BY tech_support, churn;
-- Observation:

-- Customers without tech support have higher churn
-- Customers with tech support are more likely to stay 

# DO customers with online security churn less?

-- Churn distribution based on online security
SELECT online_security, churn, COUNT(*) AS total_customers
FROM customer_data
GROUP BY online_security, churn;

-- Observation:
# Customers who have online security services are more likely to stay while customers without online security services shows churn.

-- Churn distribution based on payment method
SELECT payment_method, churn, COUNT(*) AS total_customers
FROM customer_data
GROUP BY payment_method, churn;

-- observation : The number of churned customers is almost similar across all payment methods.

-- Average tenure of churned vs retained customers
SELECT churn, AVG(tenure) AS avg_tenure
FROM customer_data
GROUP BY churn;

-- Tenure vs Churn
-- Observation:

-- Average tenure of churned customers: 33.94 months

-- Average tenure of retained customers: 37.67 months

-- Insight:

-- Customers who churn tend to have slightly lower tenure compared to customers who stay.
-- This indicates that newer customers are more likely to leave than long-term customers.

-- Business Meaning:

-- Companies should focus on improving early customer experience to reduce churn in the first few years.

-- Churn distribution based on support calls
SELECT support_calls, churn, COUNT(*) AS total_customers
FROM customer_data
GROUP BY support_calls, churn
ORDER BY support_calls;



-- Observation:

-- As the number of support calls increases, the number of churned customers decreases in the dataset.

-- Insight:

-- Customers who contact support may receive solutions to their issues, which could help reduce churn.

-- Business Interpretation:

-- Effective customer support can improve customer satisfaction and retention


-- Compare average monthly charges for churned vs retained customers
SELECT churn, AVG(monthly_charges) AS avg_monthly_charge
FROM customer_data
GROUP BY churn;

-- Customers with higher monthly charges are more likely to churn.

-- Churn rate by contract type
SELECT 
    contract,
    COUNT(CASE WHEN churn = 'Yes' THEN 1 END) * 100.0 / COUNT(*) AS churn_rate
FROM customer_data
GROUP BY contract
ORDER BY churn_rate DESC;
-- Insight: Month-to-month contracts show the highest churn rate
-- Long-term contracts help reduce churn

-- Churn rate based on tech support
SELECT 
    tech_support,
    COUNT(CASE WHEN churn = 'Yes' THEN 1 END) * 100.0 / COUNT(*) AS churn_rate
FROM customer_data
GROUP BY tech_support;

-- Insight: Customers without tech support have a higher churn rate
-- Providing tech support helps reduce churn

-- Churn rate based on online security
SELECT 
    online_security,
    COUNT(CASE WHEN churn = 'Yes' THEN 1 END) * 100.0 / COUNT(*) AS churn_rate
FROM customer_data
GROUP BY online_security;
-- Insight: In this dataset, customers with online security show slightly higher churn rate
-- This may indicate higher expectations from premium service users

-- Monthly charge categories and churn
SELECT 
CASE 
    WHEN monthly_charges < 50 THEN 'Low Charges'
    WHEN monthly_charges BETWEEN 50 AND 80 THEN 'Medium Charges'
    ELSE 'High Charges'
END AS charge_category,
COUNT(CASE WHEN churn = 'Yes' THEN 1 END) * 100.0 / COUNT(*) AS churn_rate
FROM customer_data
GROUP BY charge_category;

-- Insight: Customers with higher monthly charges have the highest churn rate
-- High-paying customers may expect better value and service

/* =====================================================
   FINAL PROJECT INSIGHTS
   ===================================================== */

-- Overall churn rate is approximately 34%

-- Month-to-month contracts have the highest churn rate

-- Customers without tech support churn more frequently

-- High monthly charges are associated with higher churn

-- Newer customers are more likely to churn than long-term customers

-- Payment method has minimal impact on churn