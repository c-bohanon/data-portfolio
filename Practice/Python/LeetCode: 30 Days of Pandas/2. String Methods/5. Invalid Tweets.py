"""
Table: Tweets

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| tweet_id       | int     |
| content        | varchar |
+----------------+---------+
tweet_id is the primary key (column with unique values) for this table.
This table contains all the tweets in a social media app.

 

Write a solution to find the IDs of the invalid tweets. The tweet is invalid if the number of characters used in the content of the tweet is strictly greater than 15.
"""

import pandas as pd

def invalid_tweets(tweets: pd.DataFrame) -> pd.DataFrame:
    df = tweets ; df = df[(df['content'].str.len() > 15)]
    df = df[['tweet_id']]
    return df
