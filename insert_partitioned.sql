CREATE DATABASE IF NOT EXISTS oreilly;
USE oreilly;

CREATE TABLE raw_data
  (year SMALLINT, month TINYINT, c1 STRING, c2 INT, c3 BOOLEAN);
-- Load some data into this unpartitioned table...
INSERT INTO

CREATE TABLE partitioned_table (c1 STRING, c2 INT, c3 BOOLEAN)
  PARTITIONED BY (year SMALLINT, month TINYINT);
-- Copy data into the partitioned table, one partition at a time.
INSERT INTO partitioned_table PARTITION (year=2000, month=1)
  SELECT c1, c2, c3 FROM raw_data WHERE year=2000 AND month=1;
INSERT INTO partitioned_table PARTITION (year=2000, month=2)
  SELECT c1, c2, c3 FROM raw_data WHERE year=2000 AND month=2;
