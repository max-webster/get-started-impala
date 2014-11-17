CREATE DATABASE IF NOT EXISTS oreilly;
USE oreilly;

/*
TK: Tear the tables down afterwards.
*/

CREATE TABLE t2 LIKE t1;
-- Copy the data, preserving the original file format.
INSERT INTO t2 SELECT * FROM t1;
ALTER TABLE t2 SET FILEFORMAT = PARQUET;
-- Now reload the data, this time converting to Parquet.
INSERT OVERWRITE t2 SELECT * FROM t1;

CREATE TABLE t3 (c1 INT, c2 STRING, c3 TIMESTAMP)
  PARTITIONED BY (state STRING, city STRING);
ALTER TABLE t3 ADD PARTITION
  (state = 'CA', city = 'San Francisco');
-- Load some text data into this partition...
ALTER TABLE t3 ADD PARTITION
  (state = 'CA', city = 'Palo Alto');
-- Load some text data into this partition...
ALTER TABLE t3 ADD PARTITION
  (state = 'CA', city = 'Berkeley');
ALTER TABLE t3 PARTITION
  (state = 'CA', city = 'Berkeley')
  SET FILEFORMAT = PARQUET;
-- Load some Parquet data into this partition...
