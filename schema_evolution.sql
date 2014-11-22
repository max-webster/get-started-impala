
CREATE DATABASE IF NOT EXISTS oreilly;
USE oreilly;

-- This example depends on the SAMPLE_DATA table created in billion_row_setup.sql.

-- Because it's a text table, we can interpret each column any way we like during a query.
-- This zero-filled numeric column is initially treated like a string.
SELECT zerofill FROM sample_data WHERE zerofill LIKE '0123%' LIMIT 5;

-- Then we change the way Impala interprets the same column.
-- Now it is considered an integer.
ALTER TABLE sample_data CHANGE zerofill zerofill INT;
SELECT zerofill AS even, zerofill+1 AS odd
  FROM sample_data
  WHERE zerofill % 2 = 0 LIMIT 5;

-- Finally we change it back to a string.
-- The underlying data files are not changed at all
-- during all these ALTER TABLE statements.
ALTER TABLE sample_data CHANGE zerofill zerofill STRING;
SELECT zerofill FROM sample_data WHERE zerofill REGEXP '1{3}' LIMIT 5;

-- Now some experiments with integer ranges.

-- We initially declare the column as the biggest integer type,
-- so there are no overflow problems when inserting the initial values.
CREATE TABLE unknown_range (x BIGINT);
INSERT INTO unknown_range VALUES (-50000), (-4000), (0), (75), (33000);

-- Then we change the column to the smallest integer type, hoping
-- that all the numbers will actually fit.
ALTER TABLE unknown_range CHANGE x x TINYINT;

-- If any numbers are out of range, they will be flattened
-- to the largest or smallest value for the applicable type.
SELECT x FROM unknown_range LIMIT 10;

-- We can check if any values are right on the edge,
-- which could indicate that the underlying values are out of range.
SELECT count(x) AS "Suspicious values" FROM unknown_range
  WHERE x IN (min_tinyint(), max_tinyint());

-- Next step is to go to the next bigger integer type and try again.
-- We keep going as long as the suspicious values query returns > 0.
ALTER TABLE unknown_range CHANGE x x SMALLINT;
SELECT x FROM unknown_range LIMIT 10;
SELECT count(x) AS "Suspicious values" FROM unknown_range
  WHERE x IN (min_smallint(), max_smallint());

ALTER TABLE unknown_range CHANGE x x INT;
SELECT x FROM unknown_range;
SELECT count(x) AS "Suspicious values" FROM unknown_range
  WHERE x IN (min_smallint(), max_smallint());

-- Get a reminder of what the numeric ranges are for integer types.
select min_bigint(), max_bigint();
select min_int(), max_int();
select min_smallint(), max_smallint();
select min_tinyint(), max_tinyint();

