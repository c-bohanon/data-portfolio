import pandas as pd 
import psycopg2 
from sqlalchemy import create_engine 

db_name = input("Enter database name: ")
csv_path = input("Enter path to .csv: ")
table_name = input("Enter table name: ")

# Connect to postgresql
db = create_engine(f"postgresql://postgres:admin@localhost/{db_name}")
connect = db.connect()

# Load csv to dataframe 
df = pd.read_csv(csv_path) 

# Load data into postgresql table 
df.to_sql(table_name, 
          con=connect, 
          if_exists='replace', 
          index=False)

print(f'Imported {df.shape[0]} rows and {df.shape[1]} columns.')
