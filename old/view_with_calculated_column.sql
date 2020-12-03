DROP VIEW IF EXISTS FOO;
CREATE VIEW foo AS
SELECT
display_name,
LEFT(date_created,10) AS application_date,
LEFT(custom_s_cohort_applied, 10) AS cohort_start_date
FROM close
WHERE LEFT(custom_s_cohort_applied,2)='20'
ORDER BY date_created;

SELECT
display_name,
application_date,
cohort_start_date,
DATE(cohort_start_date) - DATE(application_date) AS days_before_applied
FROM foo
ORDER BY days_before_applied, display_name;
