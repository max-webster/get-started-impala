/*
Because these queries do not rely on any tables,
they do not need to be run in any particular database.
*/

SELECT 1;
SELECT "hello world";
SELECT 2+2;
SELECT 10 > 5;
SELECT now();

SELECT 1 + 0.5;
SELECT 1 / 3;
SELECT 1e6, 1.5e6;
SELECT 30000 BETWEEN min_smallint() AND max_smallint();

/* Expected output:
+-------------------------------------------------+
| 30000 between min_smallint() and max_smallint() |
+-------------------------------------------------+
| true                                            |
+-------------------------------------------------+
*/

SELECT cast(1e6 AS string);
SELECT cast(true AS string);
SELECT cast(99.44 AS int);

SELECT 1 + NULL, 1 = NULL, 1 > NULL, NULL = NULL, NULL IS NULL;
SELECT cast(NULL AS STRING), cast(NULL AS BIGINT), cast(NULL AS BOOLEAN);

SELECT 'hello\nworld';
SELECT "abc\t012345\txyz";
SELECT concat('hello',NULL);
SELECT substr('hello',-2,2);

SELECT 'abc123xyz' REGEXP '[[:digit:]]{3}';

/* Expected output:
+-------------------------------------+
| 'abc123xyz' regexp '[[:digit:]]{3}' |
+-------------------------------------+
| true                                |
+-------------------------------------+
*/

SELECT regexp_extract('>>>abc<<<','.*([a-z]+)',1);

/* Expected output:
+----------------------------------------------+
| regexp_extract('>>>abc<<<', '.*([a-z]+)', 1) |
+----------------------------------------------+
| abc                                          |
+----------------------------------------------+
*/

SELECT regexp_replace('123456','(2|4|6)','x');

/* Expected output:
+------------------------------------------+
| regexp_replace('123456', '(2|4|6)', 'x') |
+------------------------------------------+
| 1x3x5x                                   |
+------------------------------------------+
*/

SELECT now() + INTERVAL 3 DAYS + INTERVAL 5 HOURS;

/* Expected output (exact date and time depends on when you run it):
+--------------------------------------------+
| now() + interval 3 days + interval 5 hours |
+--------------------------------------------+
| 2014-08-03 16:48:44.201018000              |
+--------------------------------------------+
*/

