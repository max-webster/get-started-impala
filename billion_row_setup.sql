-- impala-shell -i localhost

create database oreilly;

use oreilly;

create table sample_data
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

!hdfs dfs -put billion_rows.csv '/user/impala/warehouse/oreilly.db/sample_data';


