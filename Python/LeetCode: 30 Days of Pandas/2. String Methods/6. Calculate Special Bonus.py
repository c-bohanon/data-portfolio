"""
Table: Employees

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| employee_id | int     |
| name        | varchar |
| salary      | int     |
+-------------+---------+
employee_id is the primary key (column with unique values) for this table.
Each row of this table indicates the employee ID, employee name, and salary.

 

Write a solution to calculate the bonus of each employee. The bonus of an employee is 100% of their salary if the ID of the employee is an odd number and the employee's name does not start with the character 'M'. The bonus of an employee is 0 otherwise.

Return the result table ordered by employee_id.
"""

import pandas as pd

def calculate_special_bonus(employees: pd.DataFrame) -> pd.DataFrame:
    df = employees
    df['bonus'] = 0
    df.loc[((df['employee_id'] % 2 == 1) & (~df['name'].str.startswith('M'))), 'bonus'] = df['salary']
    df.sort_values(by='employee_id', ascending=True, inplace=True)
    return df[['employee_id', 'bonus']]
