# SQL Data Warehouse Project

## 📋 Project Overview
This project is a complete **SQL Data Warehouse** built with SQL Server, followed by **Exploratory Data Analysis (EDA)** and **Advanced Analytics** performed directly on the Gold layer.  
The goal was to design a modern data warehouse using the **Bronze → Silver → Gold** architecture, prepare clean analytical data, and use SQL to extract business insights.

---

## 🧩 Objectives
- Build an end-to-end SQL data warehouse  
- Create a clear and structured data architecture  
- Implement ETL pipelines  
- Design a clean data model (fact + dimension tables)  
- Perform SQL-based EDA and advanced analytics  

---

## 🏗️ Project Architecture
The warehouse follows the **Medallion Architecture**:

- **Bronze Layer:** Raw data loaded from CSV files  
- **Silver Layer:** Cleaned, validated, and standardized data  
- **Gold Layer:** Business-ready data prepared for reporting and analysis  

---

## ⚙️ Tools & Technologies
- **SQL Server**  
- **SQL**  
- **CSV files** as source data  

---

## 🔄 ETL Process
The project includes a full ETL pipeline:

1. **Extract** data from CSV files  
2. **Transform** using cleaning, formatting, validation, and deduplication  
3. **Load** data into Bronze → Silver → Gold layers  

Each step is implemented through SQL scripts saved in the repository.

---

## 🧮 Data Modeling
The final data model includes:

- **Fact tables** — store numerical data such as sales and quantities  
- **Dimension tables** — store descriptive information such as customers, products, and dates  


---

## 🔍 Exploratory Data Analysis (EDA)
After preparing the Gold layer, a full EDA was done using SQL to understand and explore the data.

Topics covered:
- **Database structure exploration**  
- **Dimension exploration**  
- **Date analysis**  
- **Measures exploration**  
- **Magnitude analysis**  
- **Ranking analysis**  

All EDA scripts are available in the `exploratory_data_analysis/` folder.

---

## 📈 Advanced Analytics
Advanced SQL techniques were used to answer deeper business questions.

Included analyses:
- **Sales performance over time** (yearly and monthly trends)  
- **Cumulative analysis** (running totals)  
- **Product performance comparison**  
- **Category part-to-whole analysis**  
- **Product segmentation** based on cost  
- **Customer segmentation**  
- **Customer report** summarizing main insights  

All queries are available in the `sql_advanced_analytics/` folder.

---

## 📁 Repository Structure

│
├── datawarehouse/
│   ├── datasets/         → Raw CSV files
│   ├── documents/        → Project diagrams (architecture, data model…)
│   ├── scripts/          → DDL + ETL scripts for Bronze, Silver, Gold
│   └── tests/            → Data quality check scripts
│
├── eda/
│   └── eda_queries.sql      → SQL scripts for Exploratory Data Analysis
│
├── advanced_analytics/
│   ├── sales_analysis.sql
│   ├── category_and_product_analysis.sql
│   ├── customer_segmentation.sql
│   └── customer_report.sql
│
└── README.md             → Main project documentation


---

## 📊 Results
- A full end-to-end SQL Data Warehouse  
- A Gold layer ready for BI tools and dashboards  
- Key business metrics and insights extracted with SQL  

---
