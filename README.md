## Data Source

This project uses the **Comparative Political Data Set (CPDS) 1960–2023**,
a country-level dataset containing political, institutional, and selected
economic indicators for 36 democratic countries.

For this project, the analysis is restricted to the period **2000–2019**.

Source: [Comparative Political Data Set](https://cpds-data.org/data/)

### Citation

Armingeon, Klaus, Sarah Engler, Lucas Leemann and David Weisstanner. 2025.
*Comparative Political Data Set 1960–2023.*
Zurich/Lueneburg/Lucerne: University of Zurich, Leuphana University
Lueneburg, and University of Lucerne.

### Usage

The CPDS website and codebook provide the dataset for research use and
request that users cite the dataset and, where appropriate, the original
sources. No specific standard open-data license is stated on the data page
or in the codebook.

# Government Composition and Economic Outcomes

## Project Overview

This project explores the relationship between government political composition
and economic outcomes across 36 democratic countries.

Using data from the Comparative Political Data Set (CPDS), the analysis focuses
on the period from 2000 to 2019 and examines whether different government
compositions are associated with differences in:

- real GDP growth
- unemployment
- inflation

The project follows a complete data pipeline from exploratory data analysis and
data cleaning to relational database design, SQL analysis, and Python
visualization.

The analysis is descriptive and investigates associations rather than causal
effects.

---

## Research Questions

1. How does average real GDP growth differ across government political
   compositions between 2000 and 2019?

2. How does unemployment differ across government political compositions
   between 2000 and 2019?

3. As a supporting analysis, how does inflation differ across government
   political compositions?

The initial expectation was that economic outcomes might differ between
government composition categories. The analysis tests whether the data shows
a consistent descriptive pattern.

---

## Data Pipeline

The project follows an ETL and analysis pipeline:

1. **Explore** the original CPDS dataset and identify relevant variables.
2. **Transform** the data by selecting the analysis period and variables.
3. **Normalize** the dataset into relational tables.
4. **Load** the processed data into a SQLite database.
5. **Query** the database using SQL.
6. **Analyze and visualize** the results using Pandas and Matplotlib.

The final analysis contains **720 country-year observations**, representing
36 countries across the 20-year period from 2000 to 2019.

---

## Database Design

The processed data is stored in three relational tables:

- `countries` — 36 unique countries
- `government_types` — the five government composition categories from the
  Schmidt Index
- `country_year` — 720 country-year observations containing political and
  economic variables

The `country_year` table references the two lookup tables using foreign keys.

![Database ERD](images/erd.png)

---

## SQL Analysis

The analysis uses SQL queries containing:

- `JOIN`
- `GROUP BY`
- `ORDER BY`
- `HAVING`
- aggregate functions such as `AVG()` and `COUNT()`
- a subquery

The queries investigate average GDP growth, unemployment, inflation,
country-level variation, and country-government combinations with GDP growth
above the overall dataset average.

All analytical queries are documented in `sql/queries.sql`.

---

## Key Findings

Average economic outcomes differ between government composition categories,
but the analysis does not reveal a consistent progression across the Schmidt
Index.

GDP growth varies between government categories, but the differences are
relatively small compared with the variation across individual country-year
observations. GDP growth across the categories also frequently follows similar
movements over time.

Unemployment shows substantial variation both between and within government
composition categories. The distributions overlap considerably, and no
government composition category remains consistently associated with higher
or lower unemployment throughout the full period.

Inflation also differs between categories, but no clear linear pattern appears
across the government composition scale.

Overall, the descriptive results suggest that government composition alone is
not sufficient to explain the economic patterns observed in this dataset.
Country-specific characteristics, economic cycles, and common time effects are
important factors to consider.

---

## Limitations

This analysis is descriptive and does not establish causal relationships
between government composition and economic outcomes.

The dataset combines countries with different economic structures,
institutions, and historical circumstances. Government composition can also
change in response to economic conditions, while economic policies may affect
outcomes with a time lag.

Additionally, the countries represented within each government composition
category can change from year to year.

A more advanced analysis could control for country and year effects and examine
lagged relationships between political composition and economic outcomes.

---

## Repository Structure

```text
.
├── data/
│   ├── raw/
│   └── clean/
├── images/
│   ├── erd.md
│   └── erd.png
├── notebooks/
│   ├── 01_eda.ipynb
│   ├── 02_processing.ipynb
│   └── 03_hypothesis_and_visualization.ipynb
├── sql/
│   ├── schema.sql
│   └── queries.sql
├── src/
│   └── functions.py
├── README.md
└── requirements.txt