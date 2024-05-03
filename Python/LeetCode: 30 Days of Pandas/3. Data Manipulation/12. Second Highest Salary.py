"""
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
"""

import pandas as pd


def second_highest_salary(employee: pd.DataFrame) -> pd.DataFrame:
    sorted_salaries = employee["salary"].sort_values(ascending=False)
    unique_salaries = sorted_salaries.drop_duplicates()
    if len(unique_salaries) <= 1:
        return pd.DataFrame({"SecondHighestSalary": [None]})
    else:
        second_highest = unique_salaries.iloc[1]
        return pd.DataFrame({"SecondHighestSalary": [second_highest]})
