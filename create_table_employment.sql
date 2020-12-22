DROP TABLE IF EXISTS employment_1;
DROP TABLE IF EXISTS employment_2;

CREATE TABLE employment_1 AS
SELECT
  display_name AS name,
  status_label AS status,
  SUBSTRING(custom_s_cohort_starting, 26, 3) AS campus,
  LEFT(custom_s_cohort_starting, 10) AS cohort_start_date,
  SUBSTRING(custom_s_cohort_current, 15, 10) AS cohort_end_date,
  custom_e_date_of_1st_offer AS date_of_1st_offer,
  DATE(custom_e_date_of_1st_offer) - DATE(SUBSTRING(custom_s_cohort_current, 15, 10)) AS days_before_job,
  (DATE(custom_e_date_of_1st_offer) - DATE(SUBSTRING(custom_s_cohort_current, 15, 10))) / 7 AS weeks_before_job,
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
  custom_d_previous_job AS previous_job,
  LEFT(custom_s_cohort_starting, 4) AS cohort_start_year,
  CASE
    WHEN custom_d_gender='Female' THEN 'Female'
    WHEN custom_d_gender='Male' THEN 'Male'
    ELSE 'Other'
  END AS gender_aggregate,
  CASE
    WHEN custom_d_race='White' THEN 'White'
    ELSE 'POC'
  END as race_aggregate,
  CASE
    WHEN custom_d_education IN ('high school diploma', 'Some college, no degree', 'some post high school but no degree or certificate', 'Postsecondary certificate', 'GED', 'High school diploma or equivalent', 'certificate (less than 2 years)', 'less than high school diploma', 'other') THEN 'no college degree'
    ELSE 'college degree'
  END AS education_aggregate,
  custom_e_date_of_1st_offer IS NOT NULL AS employed
  FROM close
  WHERE custom_s_cohort_current IS NOT NULL
  AND status_label NOT ILIKE 'dropped%' AND status_label NOT ILIKE 'expelled%' AND status_label NOT ILIKE 'part%' AND status_label NOT ILIKE 'enrolled'
  AND custom_e_date_of_1st_offer IS NOT NULL;

  CREATE TABLE employment_2 AS
  SELECT
    display_name AS name,
    status_label AS status,
    SUBSTRING(custom_s_cohort_starting, 26, 3) AS campus,
    LEFT(custom_s_cohort_starting, 10) AS cohort_start_date,
    SUBSTRING(custom_s_cohort_current, 15, 10) AS cohort_end_date,
    custom_e_date_of_1st_offer AS date_of_1st_offer,
    NULL AS days_before_job,
    NULL AS weeks_before_job,
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
    custom_d_previous_job AS previous_job,
    LEFT(custom_s_cohort_starting, 4) AS cohort_start_year,
    CASE
      WHEN custom_d_gender='Female' THEN 'Female'
      WHEN custom_d_gender='Male' THEN 'Male'
      ELSE 'Other'
    END AS gender_aggregate,
    CASE
      WHEN custom_d_race='White' THEN 'White'
      ELSE 'POC'
    END as race_aggregate,
    CASE
      WHEN custom_d_education IN ('high school diploma', 'Some college, no degree', 'some post high school but no degree or certificate', 'Postsecondary certificate', 'GED', 'High school diploma or equivalent', 'certificate (less than 2 years)', 'less than high school diploma', 'other') THEN 'no college degree'
      ELSE 'college degree'
    END AS education_aggregate,
    custom_e_date_of_1st_offer IS NOT NULL AS employed
    FROM close
    WHERE custom_s_cohort_current IS NOT NULL
    AND status_label NOT ILIKE 'dropped%' AND status_label NOT ILIKE 'expelled%' AND status_label NOT ILIKE 'part%' AND status_label NOT ILIKE 'enrolled'
    AND custom_e_date_of_1st_offer IS NULL;

copy employment_1 to '/Users/mgoren/Desktop/sql/employment_1.csv' CSV HEADER;
copy employment_2 to '/Users/mgoren/Desktop/sql/employment_2.csv' CSV HEADER;
