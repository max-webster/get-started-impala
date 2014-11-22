CREATE DATABASE IF NOT EXISTS oreilly;
USE oreilly;

CREATE TABLE IF NOT EXISTS bad_format (first_name STRING, last_name STRING);

-- Intentionally create values enclosed in double quotation marks.
-- In the real world, you might receive data with extra delimiters or other formatting.
-- Because Impala has no notion of optional quotation marks, those characters
-- will be displayed in query results.
-- Also, the original values are all lowercase but we want queries to return
-- values with initial caps.
INSERT INTO bad_format VALUES ('"john"','"smith"'), ('"jane"','"doe"');

-- Demonstrate that the quotation marks are displayed in query results.
SELECT first_name as "Misformatted first name", last_name as "Misformatted last name" FROM bad_format;

-- Find a regular expression that reformats the string value to remove any leading or trailing quotation mark.
SELECT regexp_replace(first_name,'(^"|"$)','') AS first_name FROM bad_format;

-- Use a chain of functions to capitalize the value once the quotes are removed.
SELECT initcap(regexp_replace(first_name,'(^"|"$)','')) AS first_name FROM bad_format;

-- Now that we have confidence in the correctness of the functions, create a view
-- as shorthand for the complicated expressions.

CREATE VIEW good_format AS
  SELECT
    initcap(regexp_replace(first_name,'(^"|"$)','')) AS first_name,
    initcap(regexp_replace(last_name,'(^"|"$)','')) AS last_name
  FROM bad_format;

-- Now a simple SELECT * gives results in exactly the format we want.
SELECT * FROM good_format;

-- Going through a sequence of functions each time is inefficient for a big data set,
-- especially in a case like this where the data is in text format.
-- So once the data is available in the right logical layout, consider a
-- final step to convert to Parquet, which can be queried more efficiently.

CREATE TABLE good_format_parquet STORED AS PARQUET AS SELECT * FROM good_format;

-- For a small data set, the file format isn't so significant.
-- But for millions, billions, or trillions of rows, or tables with
-- dozens or hundreds of columns, the speedup can be dramatic.
SELECT * FROM good_format_parquet;

