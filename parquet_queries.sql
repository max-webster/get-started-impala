CREATE DATABASE IF NOT EXISTS oreilly;
USE oreilly;

/*
TK: Create the actual tables. Tear them down afterwards.
*/

-- The query can read all the values of a column without having to
-- read (and ignore) the values of the other columns in each row.
SELECT c3 FROM t1;

-- Analytic queries are always counting, summing, averaging and so on
-- columns for sales figures, web site visitors, sensor readings, and so on.
-- Those computations are nice and fast when no unnecessary data is read.
-- In this example, the query only needs to read C1 and C5, skipping all
-- other columns.
SELECT count(DISTINCT c1), sum(c1), max(c1), min(c1), avg(c1)
  FROM t1 WHERE c5 = 0;

-- Here we cross-reference columns from two different tables, along
-- with an ID column that is common to both. Again, the query only reads
-- values from the exact columns that are needed, making join queries
-- practical for tables in the terabyte and petabyte range.
SELECT attr01, attr15, attr37, name, email FROM
  visitor_details JOIN contact_info USING (visitor_id)
  WHERE year_joined BETWEEN 2005 AND 2010;

