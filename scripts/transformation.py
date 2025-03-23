import pandas as pd
import numpy as np

def clean_csv_data(df: pd.DataFrame) -> pd.DataFrame:
    """
    Preprocesses the given DataFrame by cleaning and removing duplicates.
    """
    print("Original shape:", df.shape)

    # Standardize column names (lowercase, strip spaces)
    df.columns = df.columns.str.strip().str.lower()

    # Remove duplicate rows
    df = df.drop_duplicates()

    # Remove duplicates based on specific keys
    if {'gameid', 'shooterid'}.issubset(df.columns):
        df = df.drop_duplicates(subset=['gameid', 'shooterid'])

    if {'gameid', 'teamid'}.issubset(df.columns):
        df = df.drop_duplicates(subset=['gameid', 'teamid'])

    # Handle missing values
    df = df.dropna()

    # Reset index after cleaning
    df.reset_index(drop=True, inplace=True)

    print("Cleaned shape:", df.shape)
    print("Data cleaned successfully.")

    return df
