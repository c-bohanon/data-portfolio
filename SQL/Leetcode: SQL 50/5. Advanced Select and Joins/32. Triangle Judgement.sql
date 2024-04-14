/*
Table: Triangle

+-------------+------+
| Column Name | Type |
+-------------+------+
| x           | int  |
| y           | int  |
| z           | int  |
+-------------+------+
In SQL, (x, y, z) is the primary key column for this table.
Each row of this table contains the lengths of three line segments.

 

Report for every three line segments whether they can form a triangle.
*/

WITH cte AS (
    SELECT 
        x, y, z, 
        CASE
            WHEN x + y > z THEN 1 ELSE 0 END AS case_1,
        CASE 
            WHEN x + z > y THEN 1 ELSE 0 END AS case_2,
        CASE
            WHEN y + z > x THEN 1 ELSE 0 END AS case_3
    FROM Triangle
)
SELECT x, y, z,
    CASE
        WHEN case_1 + case_2 + case_3 = 3
        THEN 'Yes' 
        ELSE 'No'
        END AS triangle
FROM cte;
