CREATE DATABASE IF NOT EXISTS oreilly;
USE oreilly;

CREATE TABLE IF NOT EXISTS fahrenheit_temps (degrees_f FLOAT, year SMALLINT, month TINYINT, day TINYINT, location STRING);
INSERT OVERWRITE fahrenheit_temps VALUES
  (75.2,1998,6,1,"California")
  ,(77.5,1998,6,2,"Texas")
  ,(117.9,1999,8,4,"Death Valley")
  ,(-45.1,1999,8,5,"South Pole");

WITH celsius_temps AS
      (SELECT (degrees_f - 32) * 5 / 9 AS degrees_c FROM fahrenheit_temps)
    SELECT min(degrees_c), max(degrees_c), avg(degrees_c) FROM celsius_temps;

CREATE VIEW celsius_temps AS SELECT (degrees_f - 32) * 5 / 9 AS degrees_c,
  year, month, day, location FROM fahrenheit_temps;

SELECT max(degrees_c), min(degrees_c) FROM celsius_temps
  WHERE year = 1999 AND degrees_c BETWEEN -40 and 40;

CREATE VIEW celsius_pretty_printed AS
  SELECT concat(cast(degrees_c as string)," degrees Celsius") AS degrees_c,
  year, month, day, location FROM celsius_temps;

SELECT degrees_c, year, month, day location FROM celsius_pretty_printed
  WHERE year = 1998 ORDER BY year, month, day;

