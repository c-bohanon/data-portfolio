"""
Table: Accounts

+-------------+------+
| Column Name | Type |
+-------------+------+
| account_id  | int  |
| income      | int  |
+-------------+------+
account_id is the primary key (column with unique values) for this table.
Each row contains information about the monthly income for one bank account.

 

Write a solution to calculate the number of bank accounts for each salary category. The salary categories are:

    "Low Salary": All the salaries strictly less than $20000.
    "Average Salary": All the salaries in the inclusive range [$20000, $50000].
    "High Salary": All the salaries strictly greater than $50000.

The result table must contain all three categories. If there are no accounts in a category, return 0.
"""

import pandas as pd


def count_salary_categories(accounts: pd.DataFrame) -> pd.DataFrame:
    df = pd.DataFrame({"category": ["Low Salary", "Average Salary", "High Salary"]})

    low_salary = accounts[accounts["income"] < 20000]
    average_salary = accounts[
        (accounts["income"] >= 20000) & (accounts["income"] <= 50000)
    ]
    high_salary = accounts[accounts["income"] > 50000]

    df["accounts_count"] = [len(low_salary), len(average_salary), len(high_salary)]

    return df
