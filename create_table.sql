DROP TABLE IF EXISTS foo;
CREATE TABLE foo AS
SELECT
  id, 
  display_name,
  application_date,
  cohort_start_date,
  DATE(cohort_start_date) - DATE(application_date) AS days_before_applied
FROM (
  SELECT
    id,
    display_name,
    LEFT(date_created,10) AS application_date,
    LEFT(custom_s_cohort_applied, 10) AS cohort_start_date
    FROM close
    WHERE LEFT(custom_s_cohort_applied,2)='20'
) AS whatever;
