# Healthcare Prediction Dataset SQL Project

This project uses a healthcare dataset sourced from Kaggle. The raw dataset was cleaned and structured by me to prepare it for analysis. The goal of this project is to practice data cleaning and exploratory analysis using SQL.

## How I Cleaned the Healthcare Dataset

1. **Created a staging copy**  
   Made an identical copy of the dataset using the `CREATE TABLE` clause. This copy is referred to as `healthcare_prediction_staging`.

2. **Fixed column names**  
   Renamed all columns to use underscores instead of spaces with the `ALTER TABLE` clause. This avoids the need for backticks in queries.

3. **Converted date columns**  
   Changed `date_of_admission` and `discharge_date` to `DATE` format so MySQL recognizes them as actual dates. This allows easier use of `ORDER BY`, date functions, and calculations.

4. **Added an ID column**  
   Since the dataset had no unique identifier, I added an ID column to manage duplicates. I identified duplicates using `ROW_NUMBER` and verified removal with `COUNT` and `HAVING`. No duplicates remained after cleaning.

5. **Standardized names**  
   Cleaned patient and doctor names by applying `TRIM` and then formatting them with `CONCAT` for proper use of capital and lower cases.

6. **Validated discharge dates**  
   Ensured that for every patient, the discharge date is after or equal to the admission date.

7. **Checked age ranges**  
   Verified that ages fall between 0 and 110 to ensure realistic values.

---
## Healthcare Dataset Analysis
1. **Age Distribution**
   My first analysis focused on age distribution. Age is a crucial factor in healthcare, and by examining the spread, I can identify:
   Which diseases are age-related.
   Which population groups are most represented in the dataset.
   This helped me see which age group dominates the dataset.
   
2. **Gender Distribution**
   I used the `COUNT` aggregation to analyse gender.
   Male: 50%
   Female: 50%
   This shows that both genders are equally represented in the demographic.
   
3. **Blood Type Frequency**
   I performed a blood type frequency analysis using `COUNT` and `GROUP BY`. The most common blood type in the dataset is AB+.
   
4. **Disease Vulnerability by Age**
   I applied a `CASE` statement to categorise age ranges and identify vulnerability to specific diseases. The dataset shows that `Older Adults` dominate the population. They also have higher rates of diabetes and hypertension.
   
5. **Length of Stay Analysis**
   To understand hospital resource needs, I used `CASE`, `AVG(DATEDIFF)`, and `COUNT` to analyse age groups and their length of stay. Older adults tend to have longer hospital stays. This insight allows hospitals to anticipate patient volume and allocate resources more effectively.

6. **Doctor-to-Patient Ratio**
   I analysed the ratio between doctors and patients using `GROUP BY` and `HAVING`. Found a 1:1 ratio, meaning there is one doctor per patient in this dataset.
   In different healthcare settings, this type of analysis can help determine whether doctors are overworked or underutilised, which is valuable for resource planning and workload management.

7. **Hospital Trend Analysis**
   I analysed hospital appearances in the dataset. In this dataset, each hospital appears only once. Tracking hospital frequency helps plan resources, hospital beds, and staff workload effectively.
--
## Next Steps
Future commits will include:
- Power BI use to develop dashboards to monitor real-time hospital resource usage.
