# Netflix_Project

## Project Overview

This project involves a comprehensive analysis of a Netflix dataset. The data is loaded using the Kaggle API in a Jupyter Python environment, 
then transferred to a Microsoft SQL Server (MSSQL) database. Data cleaning and analysis are performed within MSSQL Server to leverage its powerful SQL querying capabilities.

## Data Loading

Data is downloaded from Kaggle using the API, ensuring that the dataset is always up-to-date.
The Netflix_Project.ipynb notebook demonstrates how to authenticate with the Kaggle API, download the dataset, and upload it to MSSQL Server.

## Data Cleaning

Data cleaning is performed using MSSQL Server. The data_cleaning_query.sql script includes SQL commands to clean the raw data directly in the database, ensuring efficient and scalable data processing.

## Data Analysis
Data analysis is conducted within MSSQL Server using the data_analysis_query.sql script. This script contains various SQL queries to explore and analyze the dataset, providing insights into Netflix's content library, user preferences, and viewing patterns.
