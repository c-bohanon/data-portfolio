"""
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
departmentId is a foreign key (reference columns) of the ID from the Department table.
Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.

 

Table: Department

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table. It is guaranteed that department name is not NULL.
Each row of this table indicates the ID of a department and its name.

 

Write a solution to find employees who have the highest salary in each of the departments.
"""

import pandas as pd


def department_highest_salary(
    employee: pd.DataFrame, department: pd.DataFrame
) -> pd.DataFrame:
  
    df = pd.merge(employee, department, left_on="departmentId", right_on="id")
    df = df.rename(
        columns={"name_x": "Employee", "name_y": "Department", "salary": "Salary"}
    )
    df = df[["Department", "Employee", "Salary"]]
    df = df.loc[df.groupby("Department")["Salary"].transform(max) == df["Salary"]]
  
    return df
