/*
  This script relies on tables already existing,
  created by billion_row_setup.sql and billion_row_normalize.sql
  and billion_rows_convert_parquet.sql.

  Make sure to run this script with in impala-shell with --verbose
  so that the elapsed time is displayed after each query.
*/

create table stats_demo like sample_data;
show table stats stats_demo;
show column stats stats_demo;

insert into stats_demo select * from sample_data limit 1000000;
compute stats stats_demo;
show table stats stats_demo;
show column stats stats_demo;

explain select count(*)
from
  sample_data join stats_demo using (id)
where
  substr(sample_data.name,1,1) = 'G';

compute stats sample_data;
show table stats sample_data;
show column stats sample_data;

explain select count(*)
from
  sample_data join stats_demo using (id)
where
  substr(sample_data.name,1,1) = 'G';

select count(*)
from
  sample_data join stats_demo using (id)
where
  substr(sample_data.name,1,1) = 'G';

/* TK: Confirm PARQUET file format is preserved in CREATE TABLE LIKE. */
create table stats_demo_parquet
  like partitioned_normalized_parquet;

compute stats partitioned_normalized_parquet;
compute stats stats_demo_parquet;
show table stats stats_demo_parquet;

explain select count(*)
from
  partitioned_normalized_parquet join stats_demo_parquet using (id)
where
  substr(partitioned_normalized_parquet.name,1,1) = 'G';

explain select count(*)
from
  partitioned_normalized_parquet join stats_demo_parquet using (id)
where
  partitioned_normalized_parquet.initial = 'G';

explain select count(*)
from
  partitioned_normalized_parquet join stats_demo_parquet using (id,initial)
where
  partitioned_normalized_parquet.initial = 'G';

select count(*)
from
  partitioned_normalized_parquet join stats_demo_parquet using (id,initial)
where
  partitioned_normalized_parquet.initial = 'G';


