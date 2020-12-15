DROP TABLE IF EXISTS retention_rate;
CREATE TABLE retention_rate AS
SELECT
  display_name,
  status_label,
  status_label NOT ILIKE 'dropped%' AND status_label NOT ILIKE 'expelled%' AND status_label NOT ILIKE 'part%' AS complete,
  LEFT(custom_s_cohort_starting, 10) AS cohort_start_date,
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
  AND status_label NOT ILIKE 'Applicant%'
  AND status_label NOT ILIKE 'Enrolled%';

copy retention_rate to '/Users/mgoren/Desktop/sql/retention_rate.csv' CSV HEADER;
