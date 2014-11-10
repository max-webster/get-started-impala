$ impala-shell
> create database food_colors;
> use food_colors;
> create table food_data
    (id int, color string, food string, weight float)
    row format delimited fields terminated by ',';
> -- Here's where we move the data files from an arbitrary
  -- HDFS location to under Impala control.
> load data inpath '/user/hive/staging' into table food_data;
Query finished, fetching results ...
+----------------------------------------------------------+
| summary                                                  |
+----------------------------------------------------------+
| Loaded 2 file(s). Total files in destination location: 2 |
+----------------------------------------------------------+
> select food, color as "Possible Color" from food_data where
    food = 'apple';
Query finished, fetching results ...
+-------+----------------+
| food  | possible color |
+-------+----------------+
| apple | red            |
| apple | green          |
+-------+----------------+
Returned 2 row(s) in 0.66s
> select food as "Top 5 Heaviest Foods", weight
    from food_data
    order by weight desc limit 5;
Query finished, fetching results ...
+----------------------------+----------------------+
| top 5 heaviest foods       | weight               |
+----------------------------+----------------------+
| orange                     | 4                    |
| apple                      | 4                    |
| apple                      | 4                    |
| scoop of vanilla ice cream | 3                    |
| banana                     | 3                    |
+----------------------------+----------------------+
Returned 5 row(s) in 0.49s
> quit;
