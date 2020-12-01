SELECT FORMAT(
  'ALTER TABLE %I.%I.%I RENAME %I to %I;',
  table_catalog,
  table_schema,
  table_name,
  column_name,
  lower(
    regexp_replace(
      replace(replace(replace(replace(replace(replace(replace(replace(replace(column_name, ' - ','_'), ' ','_'), '/','_'), '-','_'), '?',''), '(', ''), ')',''), '.', '_'), '''',''),
      '([[:lower:]])([[:upper:]])',
      '\1_\2',
      'xg'
    )
  )
)
FROM information_schema.columns
WHERE column_name ~ ' |[[:lower:]][[:upper:]]';
\gexec
