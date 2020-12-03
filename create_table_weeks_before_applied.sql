DROP TABLE IF EXISTS weeks_before_applied;
CREATE TABLE weeks_before_applied AS
SELECT
  id,
  display_name,
  application_date,
  cohort_start_date,
  DATE(cohort_start_date) - DATE(application_date) AS days_before_applied,
  (DATE(cohort_start_date) - DATE(application_date)) / 7 AS weeks_before_applied
FROM (
  SELECT
    id,
    display_name,
    LEFT(date_created,10) AS application_date,
    LEFT(custom_s_cohort_applied, 10) AS cohort_start_date
    FROM close
    WHERE LEFT(custom_s_cohort_applied,2)='20'
) AS temp;

copy weeks_before_applied to '/Users/mgoren/Desktop/sql/weeks_before_applied.csv' CSV HEADER;

-- then import into google sheets
-- create bins column counting up from 0 to max number of weeks
-- create frequency column with calculation =FREQUENCY(F:F,G:G)
-- create chart w/ weeks on horiz axis (log scale), # of students on vert axis
