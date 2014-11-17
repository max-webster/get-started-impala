CREATE DATABASE IF NOT EXISTS oreilly;
USE oreilly;

-- Set up a table to look up names based on abbreviations.
CREATE TABLE canada_regions (name STRING, abbr STRING);

-- Set up a potentially large table
-- with data values we will use to answer questions.
CREATE TABLE canada_facts
  (id STRING, sq_mi INT, population INT);

-- The INSERT statement either appends to existing data in
-- a table via INSERT INTO, or replaces the data entirely
-- via INSERT OVERWRITE.

INSERT INTO canada_regions VALUES
  ("Newfoundland and Labrador" ,"NL"),
  ("Prince Edward Island","PE"),
  ("New Brunswick","NB"), ("Nova Scotia","NS"),
  ("Quebec","PQ"), ("Ontario","ON"),
  ("Manitoba","MB"), ("Saskatchewan","SK"), ("Alberta","AB"),
  ("British Columbia","BC"), ("Yukon","YT"),
  ("Northwest Territories","NT"), ("Nunavut","NU");

INSERT OVERWRITE canada_facts VALUES ("NL",156453,514536),
  ("PE",2190,140204), ("NB",28150,751171), ("NS",21345,921727),
  ("PQ",595391,8054756), ("ON",415598,13505900),
  ("MB",250950,1208268), ("SK",251700,1033381),
  ("AB",255541,3645257), ("BC",364764,4400057),
  ("YT",186272,33897), ("NT",519734,41462), ("NU",78715,31906);

-- We can query a single table, multiple tables via joins,
-- or build new queries on top of views.
SELECT name AS "Region Name" FROM canada_regions
  WHERE abbr LIKE 'N%';

/* Expected output:
+---------------------------+
| region name               |
+---------------------------+
| Newfoundland and Labrador |
| New Brunswick             |
| Nova Scotia               |
| Northwest Territories     |
| Nunavut                   |
+---------------------------+
*/

-- This join query gets the population figure from one table
-- and the full name from another.
SELECT canada_regions.name, canada_facts.population
  FROM canada_facts JOIN canada_regions
  ON (canada_regions.abbr = canada_facts.id)
  ORDER BY population DESC;

/* Expected output:
+---------------------------+------------+
| name                      | population |
+---------------------------+------------+
| Ontario                   | 13505900   |
| Quebec                    | 8054756    |
| British Columbia          | 4400057    |
| Alberta                   | 3645257    |
| Manitoba                  | 1208268    |
| Saskatchewan              | 1033381    |
| Nova Scotia               | 921727     |
| New Brunswick             | 751171     |
| Newfoundland and Labrador | 514536     |
| Prince Edward Island      | 140204     |
| Northwest Territories     | 41462      |
| Yukon                     | 33897      |
| Nunavut                   | 31906      |
+---------------------------+------------+
*/

-- A view is an alias for a longer query, and takes no time or
-- storage to set up.
-- Querying a view avoids repeating clauses over and over,
-- allowing you to build complex queries that are still readable.
CREATE VIEW atlantic_provinces AS SELECT * FROM canada_facts
  WHERE id IN ('NL','PE','NB','NS');
CREATE VIEW maritime_provinces AS SELECT * FROM canada_facts
  WHERE id IN ('PE','NB','NS');
CREATE VIEW prairie_provinces AS SELECT * FROM canada_facts
  WHERE id IN ('MB','SK','AB');

-- Selecting from a view lets us compose a series of
-- filters and functions.
SELECT SUM(population) AS "Total Population"
  FROM atlantic_provinces;

/* Expected output:
+------------------+
| total population |
+------------------+
| 2327638          |
+------------------+
*/

SELECT AVG(sq_mi) AS "Area (Square Miles)"
  FROM prairie_provinces;

/* Expected output:
+---------------------+
| area (square miles) |
+---------------------+
| 252730.3333333333   |
+---------------------+
*/

