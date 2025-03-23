import psycopg2
import pandas as pd
import os
from transformation_updated2 import *


def connect_db():
    try:
        conn = psycopg2.connect(
            dbname="footbal_dw",
            user="postgres",
            password="123456",
            host="localhost",
        )
        return conn
    except Exception as e:
        print(f"Connection failed: {e}")
        return None




def load_csv_to_db(file_path, table_name, conn):
    cursor = None  # Declare cursor variable upfront
    try:
        if not os.path.exists(file_path):
            print(f"File {file_path} not found!")
            return

        # Attempt to detect encoding based on the file
        if 'players.csv' in file_path:
            df = pd.read_csv(file_path, encoding="ISO-8859-1")
        else:
            df = pd.read_csv(file_path, encoding="utf-8")

        # Preprocess the data
        df = clean_csv_data(df)

        cursor = conn.cursor()
        cursor.execute("SET search_path TO raw_schema;")
        conn.commit()

        # Create table dynamically based on DataFrame columns
        create_table_query = f"""
        CREATE TABLE IF NOT EXISTS raw_tables.{table_name} (
            {', '.join([f"{col} TEXT" for col in df.columns])}
        );
        """
        cursor.execute(create_table_query)
        conn.commit()

        # Insert cleaned data into the table
        for i, row in df.iterrows():
            insert_query = f"INSERT INTO raw_tables.{table_name} ({', '.join(df.columns)}) VALUES ({', '.join(['%s'] * len(row))});"
            cursor.execute(insert_query, tuple(row))
        conn.commit()
        print(f"Data loaded successfully into {table_name} table.")
    except Exception as e:
        print(f"Error processing file {file_path}: {e}")
        conn.rollback()
    finally:
        if cursor:  # Check if cursor was created before trying to close it
            cursor.close()


def process_files(file_paths, conn):
    for file_path in file_paths:
        table_name = os.path.splitext(os.path.basename(file_path))[0]
        load_csv_to_db(file_path, table_name, conn)


if __name__ == "__main__":  # Corrected the entry point check
    file_paths = [
        # Uncomment the paths as needed

        r"C:\\Users\\hp\\Desktop\\All\\college\\Third_year\\Data_Warehouse\\final_project\\project_data\\shots.csv",
        #r"C:\\Users\\hp\\Desktop\\All\\college\\Third_year\\Data_Warehouse\\final_project\\project_data\\teams.csv",
        #r"C:\\Users\\hp\\Desktop\\All\\college\\Third_year\\Data_Warehouse\\final_project\\project_data\\teamstats.csv",
        #r"C:\\Users\\hp\\Desktop\\All\\college\\Third_year\\Data_Warehouse\\final_project\\project_data\\games.csv",
        #r"C:\\Users\\hp\\Desktop\\All\\college\\Third_year\\Data_Warehouse\\final_project\\project_data\\players.csv",
        #r"C:\\Users\\hp\\Desktop\\All\\college\\Third_year\\Data_Warehouse\\final_project\\project_data\\leagues.csv",
        #r"C:\\Users\\hp\\Desktop\\All\\college\\Third_year\\Data_Warehouse\\final_project\\project_data\\appearances.csv"
    ]

    conn = connect_db()
    if conn:
        process_files(file_paths, conn)
        conn.close()



