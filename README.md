#  SQL Data Warehouse Project

## 📋 Project Overview
This project is a complete **SQL Data Warehouse** built using SQL Server, followed by an **Exploratory Data Analysis (EDA)** performed directly on the Gold layer.  
The goal was to design and implement a modern data warehouse using the **Bronze → Silver → Gold** architecture, prepare clean analytical data, and explore it using SQL to extract meaningful business insights.

---

## 🧩 Objectives
- Understand the full data warehousing process  
- Build an organized **data architecture**  
- Implement **ETL pipelines**  
- Design an efficient **data model** using **fact** and **dimension tables**  
- Perform SQL-based EDA to understand business KPIs 

---

## 🏗️ Project Architecture
The warehouse follows the **Bronze–Silver–Gold** structure:

- **Bronze Layer:** Raw data as extracted from the source (CSV files).  
- **Silver Layer:** Cleaned and transformed data, standardized and validated.  
- **Gold Layer:** Business-ready data modeled for reporting and analytical use.

---

## ⚙️ Tools & Technologies
- **SQL Server** – Main database environment  
- **SQL** – For data manipulation, transformation, and modeling  
- **CSV files** – Used as raw data sources  

---

## 🔄 ETL Process
The project includes an end-to-end **ETL pipeline**:

1. **Extract** data from multiple CSV files.  
2. **Transform** the data (cleaning, formatting, deduplication, validation).  
3. **Load** the processed data into the warehouse, following the Bronze–Silver–Gold layers.  

---

## 🧮 Data Modeling
The **data model** is designed using:
- **Fact Tables** – Store quantitative data for analysis (e.g., sales, transactions).  
- **Dimension Tables** – Contain descriptive attributes (e.g., customers, products, dates).  

This structure supports efficient analytical queries and reporting.

---

## 🔍 Exploratory Data Analysis (EDA)
After building the Gold layer, I performed a focused SQL-based EDA to understand the data and extract insights.

### EDA topics included:
- **Database exploration** — overview of gold tables and structure  
- **Dimension exploration** — countries, categories, customer attributes  
- **Date exploration** — first/last order, date ranges, age distribution  
- **Measures exploration** — total sales, avg price, total orders, quantities  
- **Magnitude analysis** — totals by country, category, gender, etc.  
- **Ranking analysis** — top/bottom products, top customers, top months

---

## 📊 Results
- A full end-to-end SQL Data Warehouse  
- A Gold layer ready for BI tools and dashboards  
- Key business metrics and insights extracted with SQL  

---

## 📁 Repository Structure

datasets/ → Raw CSV source files
documents/ → Project diagrams
scripts/ → DDL & ETL scripts for Bronze/Silver/Gold
tests/ → Data quality checks (SQL)
eda/ → SQL queries for EDA (**Exploratory Data Analysis**)
README.md → Project documentation

---
