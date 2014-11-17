create database if not exists food_colors;
use food_colors;

create table food_data
  (id int, color string, food string, weight float)
  row format delimited fields terminated by ',';
-- Here's where we move the data files from an arbitrary
-- HDFS location to under Impala control.
load data inpath '/user/hive/staging' into table food_data;
select food, color as "Possible Color" from food_data where food = 'apple';
select food as "Top 5 Heaviest Foods", weight
  from food_data
  order by weight desc limit 5;
