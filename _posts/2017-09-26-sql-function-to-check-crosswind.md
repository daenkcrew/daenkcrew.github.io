---
layout: post
title: SQL Function to Check Crosswind
tags: sql function
---
A simple function to check if a wind component is crosswind for airport runway direction planning. Using MySQL as database engine and analysis tool, this function can help to simplify checking usability factor of runway direction with given meteorogical data.

```sql
DROP FUNCTION IF EXISTS `is_crosswind`;

DELIMITER //

-- Check if wind component is a crosswind to runway direction based on tresshold value
CREATE FUNCTION `is_crosswind`(
        `tresshold` DOUBLE,         -- Knot
        `runwayDirection` DOUBLE,   -- Degree
        `windDirection` DOUBLE,     -- Degree
        `windSpeed` DOUBLE          -- Knot
    )
    -- Return 1 if crosswind, 0 if not
    RETURNS integer(1)
    LANGUAGE SQL
    DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
declare angelDeg double;
declare angelRad double;
declare crossWind double;

-- Calculate minimum angel between 2 crossing line
-- https://math.stackexchange.com/questions/341749/how-to-get-the-minimum-angle-between-two-crossing-lines
set angelDeg = abs(abs(`runwayDirection` - `windDirection`) - 180);

-- convert angel Degree to Radian
set angelRad = (pi()/180) * angelDeg;
set crossWind = sin(angelRad) * `windSpeed`;

if crossWind > `tresshold`
    then return 1;
    else return 0;
end if;
END //
DELIMITER ;
```
