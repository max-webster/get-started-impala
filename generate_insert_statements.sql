/*
This file relies on the tables that are created by the insert_partitioned.sql script.
Run that other script first.
*/

CREATE DATABASE IF NOT EXISTS oreilly;
USE oreilly;

SELECT DISTINCT
  concat('insert into partitioned_table partition (year=',
    cast(year as string),', month=',cast(month as string),
    ') select c1, c2, c3 from raw_data where year=',
    cast(year as string),' and month=',cast(month as string),';') AS command
  FROM raw_data;

/* Expected output:
+---------------------------------------------------------------------...
| command                                                             ...
+---------------------------------------------------------------------...
| insert into partitioned_table partition (year=2000, month=1) select ...
| insert into partitioned_table partition (year=2000, month=2) select ...
| insert into partitioned_table partition (year=2000, month=3) select ...
...
*/

