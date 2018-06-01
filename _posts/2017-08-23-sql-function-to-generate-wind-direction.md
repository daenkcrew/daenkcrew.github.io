---
layout: post
title: SQL Function to Generate Wind Direction
tags: sql
---
Based on [Robert Sharp][so-answer] answer on [stack overflow question][so-question], this function is tested on MySQL version 5.7.

```sql
DELIMITER //

-- Using single parameter to determine wind direction name
-- with angel is in decimal or integer
CREATE FUNCTION `get_wind_direction`(`angel` DOUBLE)
    -- Return value as varchar
    RETURNS varchar(5) CHARSET utf8
    LANGUAGE SQL
    DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
if `angel` < 0
    then set `angel` = `angel` % 360 + 360;
    else set `angel` = `angel` % 360;
end if;

return case
        when `angel` between 0 and 11.25 then 'N'
        when `angel` between 11.25 and 33.75 then 'NNE'
        when `angel` between 33.75 and 56.25 then 'NE'
        when `angel` between 56.25 and 78.25 then 'ENE'
        when `angel` between 78.25 and 101.25 then 'E'
        when `angel` between 101.25 and 123.75 then 'ESE'
        when `angel` between 123.75 and 146.25 then 'SE'
        when `angel` between 146.25 and 168.75 then 'SSE'
        when `angel` between 168.75 and 191.25 then 'S'
        when `angel` between 191.25 and 213.75 then 'SSW'
        when `angel` between 213.75 and 236.25 then 'SW'
        when `angel` between 236.25 and 258.75 then 'WSW'
        when `angel` between 258.75 and 281.25 then 'W'
        when `angel` between 281.25 and 303.75 then 'WNW'
        when `angel` between 303.75 and 326.25 then 'NW'
        when `angel` between 326.25 and 348.75 then 'NNW'
        else 'N'
    end;
END //
DELIMITER ;
```

Example :

```sql
mysql> select get_wind_direction(123);
+-------------------------+
| get_wind_direction(123) |
+-------------------------+
| ESE                     |
+-------------------------+
1 row in set (0,00 sec)

mysql> select get_wind_direction(32.54);
+---------------------------+
| get_wind_direction(32.54) |
+---------------------------+
| NNE                       |
+---------------------------+
1 row in set (0,00 sec)
```

[so-answer]: https://stackoverflow.com/a/39277268/6265296
[so-question]: https://stackoverflow.com/questions/14736464/determining-cardinal-compass-direction-between-points
