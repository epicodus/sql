-- prerequisite: column names must be normalized

CREATE OR REPLACE FUNCTION public.list_empty_columns()
  RETURNS TABLE(col_name text) AS
$func$
declare
   _column_name text;
   _count integer;
begin
  FOR _column_name IN
    SELECT column_name FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'close'
  LOOP
   EXECUTE 'SELECT COUNT(' || _column_name || ') FROM close' INTO _count;
    IF (_count = 0) THEN
      col_name := _column_name;
      RETURN NEXT;
    END IF;
  END LOOP;
END
$func$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION public.drop_empty_columns()
  RETURNS void AS
$func$
declare
   _columns_to_drop text;
begin
  SELECT string_agg(col_name, ', DROP COLUMN ') FROM list_empty_columns() INTO _columns_to_drop;
  EXECUTE 'ALTER TABLE close DROP COLUMN ' || _columns_to_drop || ';';
END
$func$ LANGUAGE plpgsql;

SELECT drop_empty_columns();
