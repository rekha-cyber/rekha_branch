"""Your reusable functions live here.

The rule from the brief: Python logic goes in `.py` files, SQL goes in `.sql`
files, and the notebooks hold the narrative. The moment a cell grows past a few
lines, or you find yourself pasting it a second time, move it here and call it
from the notebook.

To use this module from a notebook in `notebooks/`:

    import sys
    sys.path.append("..")
    from src.functions import *

The three below are only there to show the shape. Rename them, change the
arguments, write your own. This is a starting point, not an interface you have
to implement.
"""

# from pathlib import Path

# ROOT = Path(__file__).resolve().parents[1]
# RAW = ROOT / "data" / "raw"
# CLEAN = ROOT / "data" / "clean"
# DB = ROOT / "data" / "project.db"


# def clean_data(df):
#     """Fix the problems you found in notebook 01."""
#     pass


# def make_lookup(df, column):
#     """Turn a repeated categorical column into its own table with an id."""
#     pass


# def run_query(sql, db_path=DB):
#     """Run a query against the database and return the result as a DataFrame."""
#     pass



"""Reusable functions for the CPDS political and economic analysis project."""

from pathlib import Path
import sqlite3
import pandas as pd


ROOT = Path(__file__).resolve().parents[1]
RAW = ROOT / "data" / "raw"
CLEAN = ROOT / "data" / "clean"
DB = ROOT / "data" / "project.db"


def clean_data(df):
    """Select analysis variables, filter 2000–2019, and rename columns."""

    columns_to_keep = [
        "country",
        "year",
        "gov_party",
        "gov_left1",
        "gov_cent1",
        "gov_right1",
        "realgdpgr",
        "unemp",
        "inflation"
    ]

    df_clean = df[columns_to_keep].copy()

    df_clean = df_clean[
        df_clean["year"].between(2000, 2019)
    ].copy()

    df_clean = df_clean.rename(columns={
        "gov_party": "government_type",
        "gov_left1": "left_percentage",
        "gov_cent1": "centre_percentage",
        "gov_right1": "right_percentage",
        "realgdpgr": "gdp_growth",
        "unemp": "unemployment"
    })

    return df_clean


def make_lookup(df, column):
    """Create a lookup table with a numeric ID for unique column values."""

    lookup = (
        df[[column]]
        .drop_duplicates()
        .sort_values(column)
        .reset_index(drop=True)
    )

    lookup[f"{column}_id"] = lookup.index + 1

    return lookup


def run_query(sql, db_path=DB):
    """Run a SQL query and return the result as a pandas DataFrame."""

    with sqlite3.connect(db_path) as connection:
        return pd.read_sql(sql, connection)



