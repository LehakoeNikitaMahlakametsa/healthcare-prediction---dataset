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

## Next Steps
Future commits will include:
- SQL queries for exploratory analysis
- Insights and patterns discovered in the healthcare dataset
