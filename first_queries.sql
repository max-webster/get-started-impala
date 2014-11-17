/*
Because these queries do not rely on any tables,
they do not need to be run in any particular database.
*/

SELECT 1;
SELECT 2+2;
SELECT SUBSTR('Hello world',1,5);
SELECT CAST(99.5 AS INT);
SELECT CONCAT('aaa',"bbb",'ccc');
SELECT 2 > 1;
SELECT NOW() + INTERVAL 3 WEEKS;
