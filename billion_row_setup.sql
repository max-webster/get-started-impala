-- impala-shell -i localhost

CREATE DATABASE IF NOT EXISTS oreilly;
USE oreilly;

create table if not exists sample_data
  (id bigint, val int, zerofill string, name string,
  assertion boolean, city string, state string)
  row format delimited fields terminated by ",";

desc sample_data;

/* Expected output:
+-----------+---------+---------+
| name      | type    | comment |
+-----------+---------+---------+
| id        | bigint  |         |
| val       | int     |         |
| zerofill  | string  |         |
| name      | string  |         |
| assertion | boolean |         |
| city      | string  |         |
| state     | string  |         |
+-----------+---------+---------+
*/

describe formatted sample_data;

/* Expected output (except that LOCATION will differ for each different system).
...
| # Detailed Table Information | NULL
| Database:                    | oreilly
| Owner:                       | jrussell
| CreateTime:                  | Fri Jul 18 16:25:06 PDT 2014
| LastAccessTime:              | UNKNOWN
| Protect Mode:                | None
| Retention:                   | 0
| Location:                    | hdfs://a1730.abcde.example.com:8020 1
|                              | /user/impala/warehouse/oreilly.db/
|                              | sample_data
| Table Type:                  | MANAGED_TABLE
...
*/

/* TK: script this in a reliable way, to work regardless of HDFS layout. */

!hdfs dfs -put billion_rows.csv '/user/impala/warehouse/oreilly.db/sample_data';

refresh sample_data;
select count(*) from sample_data;

