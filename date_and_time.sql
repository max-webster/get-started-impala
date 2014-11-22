
-- Date and time strings formatted as YYYY-MM-DD can be cast straight to TIMESTAMP.
select cast('2014-12-01' as timestamp);

-- If the strings are formatted differently, you go through a 2-step process.
-- First turn the string into a Unix timestamp value.
select unix_timestamp('2014/12/01','yyyy/MM/dd');

-- Then call another function to turn the Unix timestamp into a TIMESTAMP value.
select from_unixtime(unix_timestamp('2014/12/01','yyyy/MM/dd'));

-- You can substitute different date/time strings and format patterns into
-- this combination of function calls.
select from_unixtime(unix_timestamp('12/01/2014','MM/dd/yyyy'));

CREATE DATABASE IF NOT EXISTS oreilly;
USE oreilly;
CREATE TABLE UNITS (granularity TINYINT, unit STRING);
INSERT INTO units VALUES (1,'year'),(2,'month'),(3,'day'),(4,'hour'), (5,'minute'),(6,'second'),(7,'millisecond');
-- Get each date and time field from a single TIMESTAMP value.
SELECT unit, extract(now(), unit) FROM units ORDER BY granularity;

-- You can construct various kinds of delta time values using addition
-- and subtraction with INTERVAL values, optionally truncating first.

select trunc(now(), 'DD') as "first thing this morning";

select trunc(now(), 'DD') + interval 8 hours as "8 AM this morning";

select now() + interval 2 weeks as "2 weeks from right now";

select trunc(now(), 'DD') - interval 2 days + interval 15 hours as "3 PM, the day before yesterday";


