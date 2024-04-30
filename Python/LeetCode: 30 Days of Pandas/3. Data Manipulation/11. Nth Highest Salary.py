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

 

Write a solution to find the nth highest salary from the Employee table. If there is no nth highest salary, return null.
"""

import pandas as pd

def nth_highest_salary(employee: pd.DataFrame, N: int) -> pd.DataFrame: 
    df = employee
    df.drop_duplicates(subset='salary', inplace=True) 
    df.sort_values(by='salary', ascending=False, inplace=True) 
    if N > len(df) or N <= 0:
        return pd.DataFrame({f'getNthHighestSalary({N})': [None]})
    else: 
        nth = df.iloc[N - 1, 1]
        return pd.DataFrame({f'getNthHighestSalary({N})': [nth]})
