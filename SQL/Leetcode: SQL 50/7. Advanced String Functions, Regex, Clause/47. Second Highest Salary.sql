/*
Table: Employee

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key (column with unique values) for this table.
Each row of this table contains information about the salary of an employee.

 

Write a solution to find the second highest salary from the Employee table. If there is no second highest salary, return null (return None in Pandas).
*/

WITH salary_table AS (
    SELECT 
        salary,
        RANK() OVER (
            ORDER BY salary DESC
        ) AS rnk
    FROM Employee
    GROUP BY salary
    ORDER BY salary DESC
)
SELECT
    CASE
        WHEN COUNT(*) >= 2
        THEN (
            SELECT salary
            FROM salary_table
            WHERE rnk = 2
        )
        ELSE NULL
        END AS SecondHighestSalary
FROM salary_table;
