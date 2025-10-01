select * from dbo.doctors
select * from dbo.patient_mapping
select * from dbo.patient_records_fact
select * from dbo.wellness_activity


-- checkingfor null

select count(*) from doctors
where doctor_id is null;

select count(*) from doctors
where doctor_name is null;

select count(*) from doctors
where specialty is null;

select count(*) from patient_records_fact
where treatment_type is null;

select count(*) from patient_records_fact
where diagnosis is null;

select count(*) from patient_records_fact
where gender is null;

select count(*) from patient_records_fact
where cost is null;

select count(*) from patient_records_fact
where visit_date is null;
 
select count(*) from patient_records_fact
where doctor_id is null;

select count(*) from patient_records_fact
where age is null;

select count(*) from patient_mapping
where patient_id is null;

select count(*) from patient_mapping
where patient_name is null;

select count(*) from patient_mapping
where health_score is null;

select count(*) from patient_mapping
where insurance_type is null;

select count(*) from patient_mapping
where primary_care_physician_id is null;

select count(*) from patient_mapping
where blood_type is null;

select count(*) from patient_mapping
where city is null

select count(*) from wellness_activity
where patient_id is null;

select count(*) from wellness_activity
where activity_date is null;

select count(*) from wellness_activity
where activity_type is null;

select count(*) from wellness_activity
where duration_minutes is null;

select count(*) from wellness_activity
where wellness_status is null;



--checking for duplicates

select doctor_id, doctor_name, specialty, count(*) RN from doctors
group by doctor_id, doctor_name, specialty
having count(*) > 1;

select patient_id, patient_name, health_score, insurance_type, primary_care_physician_id, blood_type, city, count(*) RN
		from patient_mapping
group by patient_id, patient_name, health_score, insurance_type, primary_care_physician_id, blood_type, city
		having count(*) > 1;


select patient_id, activity_type, activity_date, duration_minutes, wellness_status,count(*) from wellness_activity
group by patient_id, activity_type, activity_date, duration_minutes, wellness_status
having count(*) >1;

select patient_id, visit_date, age, gender, cost, diagnosis,doctor_id,treatment_type ,COUNT(*) from patient_records_fact
group by patient_id, visit_date, age, gender, cost, diagnosis, doctor_id,treatment_type
having COUNT(*) > 1;


---Remove duplicates

with duplicate as 
(select * ,ROW_NUMBER() over(partition by patient_id, visit_date, cost, age, gender, diagnosis,doctor_id,treatment_type
order by cost)RN
from patient_records_fact)
delete from duplicate
where RN >1;
 

 -- confirmed if deleted--
select * from patient_records_facts
where patient_id = 'p0027';

with duplicate_2 as
(select * ,ROW_NUMBER() over(partition by patient_id, activity_type, activity_date, duration_minutes, wellness_status
order by patient_id)RN from wellness_activity)
delete from duplicate_2 
where RN > 1

select * from wellness_activity;

--- Updating the tables--

select distinct insurance_type from patient_mapping

update patient_mapping
set insurance_type = 'Govt' 
where insurance_type like 'go%'

update patient_mapping
set insurance_type = 'Private'
where insurance_type like 'priva%'

select distinct city from patient_mapping
select distinct blood_type from patient_mapping

update patient_mapping
set patient_id = TRIM(patient_id),
	patient_name = TRIM(patient_name),
	city =trim(city)

	select * from doctors

update doctors
set doctor_name = UPPER(doctor_name) from doctors

select * from patient_records_fact

update dbo.patient_records_fact
set gender = case
			when gender = '?' then 'N/A'
			when gender = '123' then 'N/A'
			when gender = 'F' then 'Female'
			when gender = 'm' then 'Male'
			when gender= ' ' then 'N/A'
			when gender is null then 'N/A'
			else gender
			end 

-- updating thecost column 

		update patient_records_fact
		set cost = 0.00
		where cost  = 'free'

		update patient_records_fact
		set cost = 200.00
		where cost  = 'two hundred'

		update patient_records_fact
		set cost = 0.00
		where cost  = 'missing'

		update patient_records_fact
		set cost = 0.00
		where cost  = 'error'

		update patient_records_fact
		set cost = 0.00
		where cost is null

		select * from patient_records_fact
		update patient_records_fact
		set cost = REPLACE(cost, ',', '')

		-- change the cost column datatype 

		alter table patient_records_fact
		alter column cost decimal(10,2)


		select visit_date, DATENAME(month,visit_date) Visit_month from patient_records_fact

		-- Adding the month and year column 

		alter table patient_records_fact
		add Visit_month int,
			Visit_year int;
		
		update patient_records_fact
		set Visit_month = month(visit_date)


		update patient_records_fact
		set visit_year = year(visit_date)

		select * from patient_records_fact

		select * from wellness_activity


		 -- Total number of flu and Total cost generated from flu treatment

 select visit_year, visit_month, count(*) Number_of_flu, sum(cost) Total_cost from patient_records_fact
 where diagnosis = 'flu'
 group by visit_year, visit_month
 order by Visit_year asc, Visit_month asc;
