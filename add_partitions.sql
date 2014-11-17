CREATE DATABASE IF NOT EXISTS oreilly;
USE oreilly;

-- Set up empty partitions.
ALTER TABLE partitioned_table ADD PARTITION (year=2010, month=1);
ALTER TABLE partitioned_table ADD PARTITION (year=2010, month=2);
...
ALTER TABLE partitioned_table ADD PARTITION (year=2014, month=1);
ALTER TABLE partitioned_table ADD PARTITION (year=2014, month=2);
...

-- Move data that already exists in HDFS into appropriate partition directories.
LOAD DATA INPATH '/user/warehouse/this_year/january' INTO partitioned_table
  PARTITION (year=2014, month=1);
LOAD DATA INPATH '/user/warehouse/this_year/february' INTO partitioned_table
  PARTITION (year=2014, month=2);

-- Or tell Impala to look for specific partitions in specific HDFS directories.
ALTER TABLE partitioned_table PARTITION (year=2014, month=3)
  SET LOCATION '/user/warehouse/this_year/march';

-- If the files are not already in HDFS, shell out to an external command
-- that does 'hdfs dfs -put' or similar.
! load_projected_data_for_2020.sh
-- Make Impala aware of the files that were added by non-SQL means.
REFRESH partitioned_table;
