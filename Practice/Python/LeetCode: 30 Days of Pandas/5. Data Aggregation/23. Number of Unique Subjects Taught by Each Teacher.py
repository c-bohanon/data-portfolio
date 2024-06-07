"""
Table: Teacher

+-------------+------+
| Column Name | Type |
+-------------+------+
| teacher_id  | int  |
| subject_id  | int  |
| dept_id     | int  |
+-------------+------+
(subject_id, dept_id) is the primary key (combinations of columns with unique values) of this table.
Each row in this table indicates that the teacher with teacher_id teaches the subject subject_id in the department dept_id.

 

Write a solution to calculate the number of unique subjects each teacher teaches in the university.
"""

import pandas as pd


def count_unique_subjects(teacher: pd.DataFrame) -> pd.DataFrame:
    df = teacher.groupby("teacher_id").agg({"subject_id": "nunique"}).reset_index()
    df.rename(columns={"subject_id": "cnt"}, inplace=True)
    return df
