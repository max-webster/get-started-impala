/*
  This script relies on tables already existing,
  created by billion_row_setup.sql and billion_row_normalize.sql
  and billion_rows_convert_parquet.sql.

  Make sure to run this script with in impala-shell with --verbose
  so that the elapsed time is displayed after each query.
*/

CREATE DATABASE IF NOT EXISTS oreilly;
USE oreilly;

/* --- Simple aggregation query. --- */

select max(name) from sample_data;
select max(name) from normalized_text;
select max(name) from normalized_parquet;

/* --- Three aggregations plus some filtering. --- */

select avg(val), min(name), max(name) from sample_data
  where name between 'A' and 'D';

select avg(val), min(name), max(name) from normalized_text
  where name between 'A' and 'D';

select avg(val), min(name), max(name) from normalized_parquet
  where name between 'A' and 'D';


