CREATE DATABASE IF NOT EXISTS oreilly;
USE oreilly;

CREATE TABLE dec_vs_float (dec DECIMAL(9,3), flt FLOAT, dbl DOUBLE);
INSERT INTO dec_vs_float VALUES (98.6,cast(98.6 AS FLOAT),98.6);
SELECT * FROM dec_vs_float;

/* Expected output:
+--------+-------------------+-------------------+
| dec    | flt               | dbl               |
+--------+-------------------+-------------------+
| 98.600 | 98.59999847412109 | 98.59999999999999 |
+--------+-------------------+-------------------+
*/

