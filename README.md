Flu Season and Financial Forecasting Project

 **Overview**
This project focuses on a critical business intelligence initiative for a Rwandan clinic's financial planning department.
The goal was to provide a data-driven view of how the annual flu season impacts the clinic's finances to support accurate budget forecasting.

The core task was to analyze time-series data to identify the peak months of flu activity and the corresponding total treatment costs.

 **Dataset Schema**
The analysis utilized four distinct relational tables from the clinic's operational database:

Table Name - Key Columns - Description
Doctors - doctorid, speciality -	Information about physicians.
Patient_mapping	- patientid, insurancetype - Patient demographic and administrative details.
Wellness_activity -	patientid, activity type - Records of patient wellness activities.
Patient_records_fact - patientid, visit date, cost, diagnosis, doctor ID - The central fact table containing visit details, costs, and diagnoses.

 **Primary Analytical Task**
Title: Analyzing Monthly Trends of Flu Cases and Treatment Costs

Objectives:
Filtering: Isolate records where the diagnosis column equals 'Flu'.

Aggregation: Group the filtered data by Year and Month.

Calculation: Summarize the total case count and the total cost for each month.

Insight: Determine the months representing the absolute peak of the flu season in terms of both case volume and financial expenditure.

💻 SQL Implementation
The analysis was performed by grouping records from the Patient_records_fact table and utilizing date manipulation functions.

Query for Monthly Aggregation
This query generated the time-series summary table for the financial planning department.

SQL

created another column for the month and year
    -- Extracts Year and Month for chronological grouping (using SQL server)
    
    alter table patient_records_fact
    add Visit_year int,
       vist_month int;

    update patient_records_fact
    set  Visit_year = year(visit_date)

    update patient_records_fact
    set  Visit_date = mont(visit_date)

    select
    -- Calculates the total number of flu cases
    COUNT(*) AS "Num_of_Flu",
  
    -- Calculates the total cost associated with treating flu cases
    SUM(cost) AS "Total_Cost"
FROM
    Patient_records_fact
-- Filters for the relevant medical condition
WHERE
    diagnosis = 'Flu'
-- Groups by the time dimension
GROUP BY
    "visit_Year", "Visit_Month"
ORDER BY
        "visit_Year", "Visit_Month"

 **Key Findings and Business Insight**
Based on the aggregated results, the project identified a significant and recent shift in the clinic's peak flu season.

The provided data, spanning from 1946 to August 2025, reveals a clear, non-cyclical, upward trend in both the volume of Flu cases and their associated treatment costs. 
While flu activity was historically very low (1 to 7 cases per month) from 1946 to 2002, the period since 2003 shows increasing frequency of high-case months,
culminating in a significant surge in the most recent years.

 Peak Season Identification
1. Peak Month in Terms of Cases
The highest recorded monthly case volume occurred in August 2025, with 22 cases.

This recent peak is closely followed by:

June 2025 (21 cases)

July 2025 (19 cases)

May 2019 and April 2024 (17 cases each)

The data strongly suggests a recent, concentrated peak during the mid-year months of June, July, and August (Q3).

2. Peak Month in Terms of Cost
The highest recorded Total Flu Treatment Cost occurred in April 2024, with a cost of 5,859.88.

This peak cost is followed by:

August 2025 (5,607.42)

August 2014 (5,195.09)

The peak cost month (April 2024) does not perfectly align with the absolute peak case month (August 2025). 
This discrepancy indicates that while the volume of cases is highest in Q3 (June-August 2025), the average cost per case can be highest in other periods
(e.g., April 2024), likely due to a higher complexity of treatment, greater use of specialized resources, or different cost structures during that specific month.
And, also Four patient was treated for free in June 2025 which made the total cost for the month not aligning with the number of cases.

**Strategic Financial Insight**

The financial planning department should be aware of two distinct patterns:

Peak Volume Season (Operational Risk): The June-August (Q3) window represents the period of highest patient load and demand for resources (staffing, bed capacity, supplies). 
The massive increase to 22 cases in August 2025 indicates a severe, recent escalation in flu activity that warrants immediate attention.

Peak Expenditure Month (Financial Risk): The highest single-month cost was recorded in April 2024 (5,859.88). 
While recent months like August 2025 are close, this suggests that the April period can represent an acute financial risk, 
possibly requiring the highest allocation for expensive treatments.

Recommendation for Budget Forecasting:

The budget for flu treatment should be substantially increased and focused on the June-August (Q3) period to account for the peak volume. 
However, the budget modeling must also allocate a contingency fund in the April-May (Q2) period to cover potential high-cost treatments, 
as demonstrated by the April 2024 expenditure spike. The recent three-month surge in 2025 (June, July, August) strongly suggests the new peak season is mid-year.



