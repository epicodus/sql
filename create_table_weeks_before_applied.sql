DROP TABLE IF EXISTS weeks_before_applied;
CREATE TABLE weeks_before_applied AS
SELECT
  id,
  display_name,
  LEFT(date_created, 10) AS application_date,
  LEFT(custom_s_cohort_starting, 10) AS cohort_start_date,
  DATE(LEFT(custom_s_cohort_starting, 10)) - DATE(LEFT(date_created, 10)) AS days_before_applied,
  (DATE(LEFT(custom_s_cohort_starting, 10)) - DATE(LEFT(date_created, 10))) / 7 AS weeks_before_applied,
  custom_s_cohort_applied AS cohort_applied,
  custom_s_cohort_starting AS cohort_starting,
  custom_s_cohort_current AS cohort_current,
  custom_d_work_eligibility_usa AS work_eligibility_usa,
  custom_d_birth_date AS birth_date,
  custom_d_cs_degree AS cs_degree,
  custom_d_diploma AS diploma,
  custom_d_disability AS disability,
  custom_d_over_18 AS over_18,
  custom_d_previous_salary AS previous_salary,
  custom_d_time_off_planned AS time_off_planned,
  custom_d_veteran AS veteran,
  custom_d_work_eligibility_job_search_country AS work_eligibility_job_search_country,
  custom_d_after_graduation_plan AS after_graduation_plan,
  custom_d_pronouns AS pronouns,
  custom_d_race AS race,
  custom_d_education AS education,
  custom_d_gender AS gender,
  custom_d_previous_job AS previous_job
  FROM close
  WHERE custom_s_cohort_starting IS NOT NULL
  AND LEFT(custom_s_cohort_starting,2)='20';

copy weeks_before_applied to '/Users/mgoren/Desktop/sql/weeks_before_applied.csv' CSV HEADER;

-- then import into google sheets
-- create bins column counting up from 0 to 39, and then label next row >= 40
-- create frequency column with calculation =FREQUENCY(F:F,G:G)
-- create chart w/ weeks on horiz axis, # of students on vert axis
