#! /bin/bash

# Create data file with problematic dates including 2-digit years.
cat <<HERE >20th_century.dat
John Smith,06-04-52,false
Jane Doe,03-22-76,true
HERE

# Create more modern data file with dates including 4-digit years.
cat <<HERE >2014_new_customers.dat
Adam Millennial,01-01-2000,true
Maria Sanchez,03-29-2001,true
HERE

impala-shell -i localhost -d oreilly -q 'CREATE TABLE inconsistent_data (name STRING, birthdate STRING, living BOOLEAN) ROW FORMAT DELIMITED FIELDS TERMINATED BY ","'

# TK: reformat the Location: output to extract just the HDFS path, assign to env var.
impala_table_dir=
impala-shell --quiet -B -i localhost -d oreilly -q 'DESCRIBE FORMATTED inconsistent_data' | grep Location:

hdfs dfs -put 20th_century.dat 2014_new_customers.dat $impala_table_dir

impala-shell --quiet -i localhost -d oreilly -q 'REFRESH inconsistent_data'

impala-shell --quiet -i localhost -d oreilly -q 'SELECT * FROM inconsistent_data LIMIT 50'

