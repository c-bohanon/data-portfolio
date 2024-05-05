/*
Table: Logs

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
In SQL, id is the primary key for this table.
id is an autoincrement column.

 

Find all numbers that appear at least three times consecutively.
*/

SELECT DISTINCT num AS ConsecutiveNums
FROM (
    SELECT 
        id,
        num,
        LAG(num) OVER (ORDER BY id) AS previous,
        LEAD(num) OVER (ORDER BY id) AS nxt
    FROM Logs
) AS tbl
WHERE num = previous
    AND num = nxt;
