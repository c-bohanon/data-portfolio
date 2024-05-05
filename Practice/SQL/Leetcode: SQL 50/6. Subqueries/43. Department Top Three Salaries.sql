/*
Table: Employee

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| id           | int     |
| name         | varchar |
| salary       | int     |
| departmentId | int     |
+--------------+---------+
id is the primary key (column with unique values) for this table.
departmentId is a foreign key (reference column) of the ID from the Department table.
Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.

 

Table: Department

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the ID of a department and its name.

 

A company's executives are interested in seeing who earns the most money in each of the company's departments. A high earner in a department is an employee who has a salary in the top three unique salaries for that department.

Write a solution to find the employees who are high earners in each of the departments.
*/

SELECT 
    d.name AS Department, 
    e2.employee_name AS Employee, 
    e2.salary AS Salary
FROM (
    SELECT 
        e.id AS employee_id,
        e.name AS employee_name,
        e.salary, 
        e.departmentId, 
        r.dept_salary_rank
    FROM Employee e
    JOIN (
        SELECT 
            departmentId,
            salary,
            RANK() OVER (
                PARTITION BY departmentId 
                ORDER BY salary DESC
            ) AS dept_salary_rank
        FROM Employee
        GROUP BY 
            departmentId,
            salary
        ) AS r
        ON e.salary = r.salary
        AND e.departmentId = r.departmentId
    ) AS e2
JOIN Department d
    ON e2.departmentId = d.id
WHERE e2.dept_salary_rank <= 3 
