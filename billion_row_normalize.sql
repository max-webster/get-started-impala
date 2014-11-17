/*
  This script relies on tables already existing,
  created by billion_row_setup.sql.
*/

CREATE DATABASE IF NOT EXISTS oreilly;
USE oreilly;

select avg(length(city)) + avg(length(state))
  from sample_data;

describe formatted usa_cities;

/* TK: Also script this part to work regardless of HDFS layout. */
!hdfs dfs -put usa_cities.csv '/user/impala/warehouse/oreilly.db/usa_cities';

refresh usa_cities;

select count(*) from usa_cities;
show table stats usa_cities;
select * from usa_cities limit 5;

create view normalized_view as select
  one.id, one.val, one.zerofill, one.name, one.assertion,
  two.id as location_id
from
  sample_data one
join
  usa_cities two
on (one.city = two.city and one.state = two.state);


select one.id, one.location_id, two.id, two.city, two.state
from
  normalized_view one
join
  usa_cities two
on (one.location_id = two.id)
limit 5;

select id, city, state from sample_data
where id in (15840253, 15840254, 15840255, 15840256, 15840257);

create table normalized_text
  row format delimited fields terminated by ","
  as select * from normalized_view;

select * from normalized_text limit 5;

show table stats normalized_text;

