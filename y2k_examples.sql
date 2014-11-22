CREATE DATABASE IF NOT EXISTS oreilly;
USE oreilly;

CREATE VIEW customer_data_separate_fields AS
  SELECT
    name,
    regexp_extract(birthdate,'([[:digit:]]+)-([[:digit:]]+)-([[:digit:]]+)', 1) month,
    regexp_extract(birthdate,'([[:digit:]]+)-([[:digit:]]+)-([[:digit:]]+)', 2) day,
    regexp_extract(birthdate,'([[:digit:]]+)-([[:digit:]]+)-([[:digit:]]+)', 3) year,
    living
  FROM inconsistent_data;

SELECT * FROM customer_data_separate_fields LIMIT 50;

CREATE VIEW customer_data_int_fields AS
  SELECT name, cast(month AS TINYINT) month,
    cast(day AS TINYINT) day,
    cast(year AS SMALLINT) year,
    living
    FROM customer_data_separate_fields;

CREATE VIEW customer_data_full_years AS
  SELECT name, month, day,
    CASE
      WHEN year IS NULL THEN NULL
      WHEN year < 100 THEN year + 1900
      ELSE year
    END
    AS year,
    living
  FROM customer_data_int_fields;

-- Doublecheck that the data is OK.
SELECT * FROM customer_data_full_years LIMIT 50;

CREATE TABLE modernized_customer_data
  STORED AS PARQUET
  AS SELECT * FROM customer_data_full_years;

SELECT * FROM modernized_customer_data LIMIT 50;


