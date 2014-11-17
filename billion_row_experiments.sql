/*
  This script relies on tables already existing,
  created by billion_row_setup.sql.
*/

CREATE DATABASE IF NOT EXISTS oreilly;
USE oreilly;

select min(name) as first_in_alpha_order, assertion
  from sample_data group by assertion;

select avg(val), min(name), max(name) from sample_data
  where name between 'A' and 'D';

select count(name) as num_names, assertion
  from sample_data group by assertion;

show table stats sample_data;

