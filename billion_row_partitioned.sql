/*
  This script relies on tables already existing,
  created by billion_row_setup.sql and billion_row_normalize.sql
  and billion_rows_convert_parquet.sql.

  Make sure to run this script with in impala-shell with --verbose
  so that the elapsed time is displayed after each query.
*/

CREATE DATABASE IF NOT EXISTS oreilly;
USE oreilly;

create view partitioned_normalized_view as
  select id, val, zerofill, name, assertion, location_id, substr(name,1,1) as initial
  from normalized_parquet;

select id, name, initial
  from partitioned_normalized_view limit 5;

create table partitioned_normalized_parquet
  (id bigint, val int, zerofill string, name string, assertion boolean, location_id smallint)
  partitioned by (initial string) stored as parquet;

insert into partitioned_normalized_parquet partition(initial)
  select * from partitioned_normalized_view;

show table stats partitioned_normalized_parquet;

select avg(val), min(name), max(name)
  from normalized_parquet where substr(name,1,1) = 'Q';

select avg(val), min(name), max(name)
  from partitioned_normalized_parquet where initial = 'Q';

select avg(val), min(name), max(name)
  from normalized_parquet
  where substr(name,1,1) between 'A' and 'C';

select avg(val), min(name), max(name)
  from partitioned_normalized_parquet
  where initial between 'A' and 'C';

select avg(val), min(name), max(name)
  from partitioned_normalized_parquet;

select avg(val), min(name), max(name)
  from normalized_parquet;



