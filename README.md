# Brazilian E-Commerce Data Analytics Project

## Project Overview

This project focuses on end-to-end data analytics using the **Brazilian E-Commerce Public Dataset by Olist**. The objective was to simulate an industry-grade analytics workflow starting from raw data ingestion up to **foundational business analysis and Power BI reporting readiness**. The project is designed to demonstrate strong fundamentals in **SQL, data modeling, data quality assessment, and business-oriented analysis**, aligned with real-world data analyst expectations.


---

## Business Context

Olist is a Brazilian e-commerce platform that connects small businesses to major online marketplaces. The dataset represents real commercial transactions, including orders, customers, sellers, payments, logistics, and product details. This makes it highly suitable for practicing analytical problem-solving in an e-commerce domain.

---

## Objectives

* Build a clean, relational database from raw CSV files
* Apply industry-standard data modeling practices
* Ensure data integrity using primary and foreign keys
* Perform data cleaning and validation
* Conduct foundational business analysis using SQL
* Prepare the dataset for dashboarding and reporting in Power BI

---

## Dataset Details

* Source: Brazilian E-Commerce Public Dataset by Olist
* Format: Multiple CSV files
* Domain: E-commerce (Orders, Customers, Products, Payments, Logistics)
* Records: ~100k orders across multiple related tables

---

## Tools & Technologies

* **Database:** SQL Server
* **Query Language:** T-SQL
* **Visualization Tool:** Power BI
* **Version Control:** Git & GitHub
* **Data Source Format:** CSV

---

## Project Workflow

### 1. Environment Setup

* Installed and configured SQL Server and SQL Server Management Studio (SSMS)
* Set up Power BI Desktop for visualization
* Initialized GitHub repository for version control

---

### 2. Data Ingestion

* Imported all CSV files into SQL Server
* Created individual tables for each dataset (orders, order_items, customers, sellers, products, payments, reviews, etc.)
* Ensured correct data types for dates, numeric values, and text fields

---

### 3. Data Modeling & Schema Design

* Designed a **relational schema** following normalization principles
* Identified and assigned **Primary Keys (PK)** for all tables
* Implemented **Foreign Key (FK)** relationships to enforce referential integrity
* Created composite keys where required (e.g., order_id + order_item_id)
* Validated one-to-many and many-to-one relationships across tables

---

### 4. Data Quality Assessment

* Checked for null values in critical columns
* Identified duplicate records and handled them appropriately
* Validated date ranges (order purchase, approval, shipping, delivery)
* Ensured numeric consistency for price, freight, and payment values

---

### 5. Data Cleaning & Standardization

* Standardized date formats
* Renamed columns for clarity and consistency
* Removed irrelevant or redundant columns
* Ensured consistent naming conventions across tables

---

### 6. Foundational Business Analysis (SQL)

Performed core business analysis using SQL queries, including:

* Order volume trends
* Average delivery time (purchase to delivery)
* Revenue analysis using price and freight value
* Payment method distribution
* Customer purchase behavior
* Seller performance overview
* Order status analysis (delivered, canceled, shipped)

These analyses were designed to answer **basic but high-impact business questions** typically expected at an entry-level or junior data analyst role.

---

### 7. Power BI Integration

* Connected SQL Server database to Power BI
* Verified relationships using the data model view
* Prepared clean fact and dimension tables
* Applied basic transformations where needed
* Dataset finalized and ready for dashboard creation

---

## Key Outcomes

* Built a fully relational e-commerce database
* Applied real-world data modeling standards
* Answered business-relevant questions using SQL
* Prepared analytics-ready data for BI reporting
* Followed a structured, end-to-end analytics workflow

---

## Skills Demonstrated

* SQL (DDL, DML, Joins, Aggregations)
* Data Modeling & Normalization
* Data Cleaning & Validation
* Business-Oriented Data Analysis
* Power BI Data Preparation
* GitHub Project Documentation

---

## Future Enhancements

* Advanced SQL analysis (cohort analysis, RFM analysis)
* Interactive Power BI dashboards
* KPI tracking (delivery SLA, seller ratings, repeat customers)
* Performance optimization using indexes and views

---

