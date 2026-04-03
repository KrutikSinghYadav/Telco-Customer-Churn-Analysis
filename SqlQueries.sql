-- 1. Overall churn rate 
SELECT
  COUNT(*) AS total_customers,
  SUM(CASE WHEN Churn = TRUE THEN 1 ELSE 0 END) AS churned,
  ROUND(100.0 * SUM(CASE WHEN Churn = TRUE THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM `cyclistic-1st-case-study.Telco_churn_prediction.telco_churn`
-- 2. Churn by contract type
SELECT
  Contract,
  COUNT(*) AS customers,
  SUM(CASE WHEN Churn = TRUE THEN 1 ELSE 0 END) AS churned,
  ROUND(100.0 * SUM(CASE WHEN Churn = TRUE THEN 1 ELSE 0 END) / COUNT(*), 1) AS churn_pct
FROM `cyclistic-1st-case-study.Telco_churn_prediction.telco_churn`
GROUP BY Contract
ORDER BY churn_pct DESC;
-- 3. Avg tenure: churned vs retained 
select Churn, ROUND(AVG(MonthlyCharges), 2)   AS avg_monthly_charge, round(avg(tenure_in_months),2) as average_tenure_months
from `cyclistic-1st-case-study.Telco_churn_prediction.telco_churn`
group by Churn
-- 4. Churn by internet service
SELECT
  InternetService,
  COUNT(*) AS customers,
  ROUND(100.0 * SUM(CASE WHEN Churn = TRUE THEN 1 ELSE 0 END) / COUNT(*), 1) AS churn_pct
FROM `cyclistic-1st-case-study.Telco_churn_prediction.telco_churn`
GROUP BY InternetService
ORDER BY churn_pct DESC;
-- 5. High-risk segment: high on risk customers which are expected to churn
SELECT
  COUNT(*) AS high_risk_customers,
  ROUND(100.0 * SUM(CASE WHEN Churn = TRUE THEN 1 ELSE 0 END) / COUNT(*), 1) AS churn_pct
FROM `cyclistic-1st-case-study.Telco_churn_prediction.telco_churn`
WHERE Contract = 'Month-to-month'
  AND InternetService = 'Fiber optic'
  AND OnlineSecurity = 'No';
-- 6. Revenue at risk 
SELECT
  Churn,
  COUNT(*) AS customers,
  ROUND(SUM(MonthlyCharges), 2) AS monthly_revenue
FROM `cyclistic-1st-case-study.Telco_churn_prediction.telco_churn`
GROUP BY Churn;
--7 Major root cause 
SELECT 
    SUM(MonthlyCharges) AS total_monthly_revenue_lost,
    COUNT(customerID) AS customer_count
from `cyclistic-1st-case-study.Telco_churn_prediction.telco_churn`
WHERE 
    Churn = TRUE 
    AND Contract = 'Month-to-month' 
    AND OnlineSecurity = 'No' 
    AND InternetService = 'Fiber optic';
