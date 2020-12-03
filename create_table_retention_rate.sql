DROP TABLE IF EXISTS retention_rate;
CREATE TABLE retention_rate AS
SELECT
  display_name,
  status_label,
  custom_d_work_eligibility_usa,
  custom_d_age_legacy,
  custom_d_birth_date,
  custom_d_cs_degree,
  custom_d_diploma,
  custom_d_disability,
  custom_d_over_18,
  custom_d_previous_salary,
  custom_d_time_off_planned,
  custom_d_veteran,
  custom_d_work_eligibility_job_search_country,
  custom_d_after_graduation_plan,
  custom_d_pronouns,
  custom_d_race,
  custom_d_education,
  custom_d_encrypted_ssn,
  custom_d_gender,
  custom_d_shirt_size,
  custom_d_previous_job
  FROM close
  WHERE custom_s_cohort_starting IS NOT NULL
  AND status_label NOT ILIKE 'Applicant%'
  AND status_label NOT ILIKE 'Enrolled%';

copy retention_rate to '/Users/mgoren/Desktop/sql/retention_rate.csv' CSV HEADER;

-- need to include demographics columns!

-- add bins and frequencies:
-- =countif(B:B,"employed*")
-- =countif(B:B,"previously*")
-- =countif(B:B,"graduated - no internship")
-- =countif(B:B,"non-reporting")
-- =countif(B:B,"unemployed*")
-- =countif(B:B,"part-time graduate")
-- =countif(B:B,"dropped*")
-- =countif(B:B,"expelled*")
