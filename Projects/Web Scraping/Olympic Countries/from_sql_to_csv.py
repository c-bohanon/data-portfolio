import pandas as pd
from sqlalchemy import create_engine

db_name = "olympic_countries"
table_name = "country_table"

# create sqlalchemy engine
engine = create_engine(f"postgresql://postgres:admin@localhost/{db_name}")
connect = engine.connect()

# read table from database into pandas dataframe
df = pd.read_sql_table(table_name, engine)

df.to_csv("olympic_countries.csv")
