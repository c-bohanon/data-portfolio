"""
Table: Employees

+-------------+------+
| Column Name | Type |
+-------------+------+
| emp_id      | int  |
| event_day   | date |
| in_time     | int  |
| out_time    | int  |
+-------------+------+
(emp_id, event_day, in_time) is the primary key (combinations of columns with unique values) of this table.
The table shows the employees' entries and exits in an office.
event_day is the day at which this event happened, in_time is the minute at which the employee entered the office, and out_time is the minute at which they left the office.
in_time and out_time are between 1 and 1440.
It is guaranteed that no two events on the same day intersect in time, and in_time < out_time.

 

Write a solution to calculate the total time in minutes spent by each employee on each day at the office. Note that within one day, an employee can enter and leave more than once. The time spent in the office for a single entry is out_time - in_time.
"""

import pandas as pd


def total_time(employees: pd.DataFrame) -> pd.DataFrame:
    df = (
        employees.groupby(["emp_id", "event_day"])[["in_time", "out_time"]]
        .sum()
        .reset_index()
    )
    df["total_time"] = df["out_time"] - df["in_time"]
    df = df.rename(columns={"event_day": "day"})
    return df[["day", "emp_id", "total_time"]]
