SELECT age, COUNT(*) AS patient_count
FROM healthcare_prediction_staging
GROUP BY age
ORDER BY patient_count DESC;

SELECT medical_condition,
CASE
WHEN age < 18 THEN 'Child'
WHEN age BETWEEN 18 AND 29 THEN 'Young Adult'
WHEN age BETWEEN 30 AND 50 THEN 'Middle Age Adult'
ELSE 'Old Aged Adult'
END AS age_group,
COUNT(*) AS count
FROM healthcare_prediction_staging
GROUP BY medical_condition, age_group
ORDER BY count DESC;


SELECT 
CASE
WHEN age < 18 THEN 'Child'
WHEN age BETWEEN 18 AND 29 THEN 'Young Adult'
WHEN age BETWEEN 30 AND 50 THEN 'Middle Age Adult'
ELSE 'Old Aged Adult'
END AS age_group,
  AVG(DATEDIFF(discharge_date, date_of_admission)) AS avg_stay,
  COUNT(*) AS patient_count
FROM healthcare_prediction_staging
GROUP BY age_group
ORDER BY avg_stay DESC;


SELECT 
CASE
WHEN age < 18 THEN 'Child'
WHEN age BETWEEN 18 AND 29 THEN 'Young Adult'
WHEN age BETWEEN 30 AND 50 THEN 'Middle Age Adult'
ELSE 'Old Aged Adult'
END AS age_group,
AVG(DATEDIFF(discharge_date, date_of_admission)) AS avg_stay,
  AVG(billing_amount) AS avg_billing,
  COUNT(*) AS patient_count
FROM healthcare_prediction_staging
GROUP BY age_group
ORDER BY avg_billing DESC;
