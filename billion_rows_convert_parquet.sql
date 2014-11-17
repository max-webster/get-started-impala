/*
  This script relies on tables already existing,
  created by billion_row_setup.sql and billion_row_normalize.sql.
*/

CREATE DATABASE IF NOT EXISTS oreilly;
USE oreilly;

create table normalized_parquet
  stored as parquet
  as select * from normalized_text;

select count(*) from normalized_parquet;

show table stats normalized_parquet;

/* Denormalized Parquet table created only for size comparison, not used in performance tests. */

create table denormalized_parquet
  stored as parquet
  as select * from sample_data;

show table stats denormalized_parquet;


