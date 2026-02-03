SELECT *
FROM healthcare_prediction;

CREATE TABLE healthcare_prediction_staging
LIKE healthcare_prediction;

SELECT *
FROM healthcare_prediction_staging;

INSERT healthcare_prediction_staging
SELECT *
FROM healthcare_prediction;

SELECT *
FROM healthcare_prediction_staging;


ALTER TABLE healthcare_prediction_staging
CHANGE COLUMN `Billing Amount` billing_amount DECIMAL (10, 2);

ALTER TABLE healthcare_prediction_staging
CHANGE COLUMN `ï»¿Name` name VARCHAR(100),
CHANGE COLUMN `Age` age VARCHAR(10),
CHANGE COLUMN `Gender` gender VARCHAR(10),
CHANGE COLUMN `Blood Type` blood_type VARCHAR(5),
CHANGE COLUMN `Medical Condition` medical_condition TEXT,
CHANGE COLUMN `Date of Admission` date_of_admission VARCHAR(20),
CHANGE COLUMN `Doctor` doctor VARCHAR(100),
CHANGE COLUMN `Hospital` hospital VARCHAR(100),
CHANGE COLUMN `Insurance Provider` insurance_provider VARCHAR(100),
CHANGE COLUMN `Room Number` room_number VARCHAR(10),
CHANGE COLUMN `Admission Type` admission_type VARCHAR(20),
CHANGE COLUMN `Discharge Date` discharge_date VARCHAR(20),
CHANGE COLUMN `Medication` medication TEXT,
CHANGE COLUMN `Test Results` test_results TEXT;

UPDATE healthcare_prediction_staging
SET date_of_admission = STR_TO_DATE(date_of_admission, '%d/%m/%Y'),
    discharge_date = STR_TO_DATE(discharge_date, '%d/%m/%Y');

ALTER TABLE healthcare_prediction_staging
MODIFY date_of_admission DATE,
MODIFY discharge_date DATE;

SHOW COLUMNS 
FROM healthcare_prediction_staging;

SELECT * 
FROM healthcare_set.healthcare_prediction_staging;

ALTER TABLE healthcare_prediction_staging
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;

WITH duplicates AS (
SELECT gender, blood_type, medical_condition, date_of_admission, doctor, hospital, insurance_provider, billing_amount, room_number, admission_type, 
discharge_date, medication, test_results,
ROW_NUMBER() OVER (PARTITION BY gender, blood_type, medical_condition, date_of_admission,
       doctor, hospital, insurance_provider, billing_amount, room_number,
       admission_type, discharge_date, medication, test_results ORDER BY id)
AS row_num
FROM healthcare_prediction_staging
)
SELECT *
FROM duplicates
WHERE row_num > 1;

SELECT name, age, gender, blood_type, medical_condition, date_of_admission,
       doctor, hospital, insurance_provider, billing_amount, room_number,
       admission_type, discharge_date, medication, test_results,
       COUNT(*) AS cnt
FROM healthcare_prediction_staging
GROUP BY name, age, gender, blood_type, medical_condition, date_of_admission,
         doctor, hospital, insurance_provider, billing_amount, room_number,
         admission_type, discharge_date, medication, test_results
HAVING COUNT(*) > 1;

UPDATE healthcare_prediction_staging
SET name = TRIM(name);

UPDATE healthcare_prediction_staging
SET name = CONCAT(
    UPPER(LEFT(SUBSTRING_INDEX(name, ' ', 1), 1)),
    LOWER(SUBSTRING(SUBSTRING_INDEX(name, ' ', 1), 2)),
    ' ',
    UPPER(LEFT(SUBSTRING_INDEX(name, ' ', -1), 1)),
    LOWER(SUBSTRING(SUBSTRING_INDEX(name, ' ', -1), 2))
);

UPDATE healthcare_prediction_staging
SET doctor = TRIM(doctor);

SELECT id, name, date_of_admission, discharge_date
FROM healthcare_prediction_staging
WHERE discharge_date > date_of_admission;

SELECT id, name, billing_amount, insurance_provider
FROM healthcare_prediction_staging
WHERE billing_amount > 0 AND (insurance_provider IS NULL OR insurance_provider = '');

SELECT *
FROM healthcare_prediction_staging
WHERE billing_amount IS NULL;

SELECT id, name, age, medical_condition
FROM healthcare_prediction_staging
WHERE age < 0 OR age > 110;

SELECT DISTINCT admission_type
FROM healthcare_prediction_staging
ORDER BY admission_type;

SELECT DISTINCT medication
FROM healthcare_prediction_staging;

SELECT id, name, admission_type
FROM healthcare_prediction_staging
WHERE admission_type NOT IN ('Emergency', 'Urgent', 'Elective');