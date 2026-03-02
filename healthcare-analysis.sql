SELECT age, COUNT(*) AS patient_count
FROM healthcare_prediction_staging
GROUP BY age
ORDER BY patient_count DESC;

SELECT gender, COUNT(*) AS patient_count
FROM healthcare_prediction_staging
GROUP BY gender
ORDER BY patient_count DESC;

SELECT gender,
       COUNT(*) AS patient_count,
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM healthcare_prediction_staging), 2) AS percentage
FROM healthcare_prediction_staging
GROUP BY gender
ORDER BY patient_count DESC;

SELECT gender, admission_type, COUNT(*) AS count
FROM healthcare_prediction_staging
GROUP BY gender, admission_type
ORDER BY gender, count DESC;

SELECT blood_type, COUNT(*) AS patient_count
FROM healthcare_prediction_staging
GROUP BY blood_type
ORDER BY patient_count DESC;

SELECT blood_type,
       COUNT(*) AS patient_count,
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM healthcare_prediction_staging), 2) AS percentage
FROM healthcare_prediction_staging
GROUP BY blood_type
ORDER BY patient_count DESC;

SELECT medical_condition, COUNT(*)
FROM healthcare_prediction_staging
GROUP BY medical_condition
ORDER BY COUNT(*) DESC;

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

SELECT doctor, COUNT(*)
FROM healthcare_prediction_staging
GROUP BY doctor
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC;

SELECT hospital, COUNT(*) AS admission_count
FROM healthcare_prediction_staging
GROUP BY hospital
HAVING COUNT(*) > 1
ORDER BY admission_count DESC;
