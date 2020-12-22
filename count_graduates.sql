SELECT COUNT(*) AS graduates_count
FROM close
WHERE custom_s_cohort_current IS NOT NULL
AND status_label NOT ILIKE 'dropped%' AND status_label NOT ILIKE 'expelled%' AND status_label NOT ILIKE 'part%' AND status_label NOT ILIKE 'enrolled';
