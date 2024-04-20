/*
Table: Seat

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| student     | varchar |
+-------------+---------+
id is the primary key (unique value) column for this table.
Each row of this table indicates the name and the ID of a student.
id is a continuous increment.

 

Write a solution to swap the seat id of every two consecutive students. If the number of students is odd, the id of the last student is not swapped.

Return the result table ordered by id in ascending order.
*/

SELECT 
    CASE
        WHEN id != (SELECT COUNT(*) FROM Seat) AND id % 2 != 0 THEN id + 1
        WHEN id % 2 = 0 THEN id - 1
        ELSE (
            SELECT
                CASE WHEN COUNT(*) % 2 = 1 THEN MAX(id) ELSE NULL END AS id
            FROM Seat)
        END AS id,
    student
FROM Seat
ORDER BY id;
