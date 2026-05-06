# VisaPath: Cloud-Based Visa Sponsorship Analytics Platform
VisaPath is a cloud-based analytics platform that helps international job seekers explore U.S. visa sponsorship trends by employer, location, industry, and occupation.

## Tech Stack
- Cloud: AWS S3, Glue, RDS PostgreSQL, EC2, ALB, CloudWatch
- Application: Streamlit, Python
- Database: PostgreSQL
- Data Processing: AWS Glue, PySpark, SQL
- Data Sources: USCIS H-1B Employer Data, DOL PERM Labor Certification Data

## Key Features
- Processes 1.1GB+ public sponsorship datasets
- Cleans and standardizes employer, location, occupation, and wage-related fields
- Loads curated tables into Amazon RDS PostgreSQL
- Provides an interactive Streamlit dashboard for sponsorship trend analysis
- Uses CloudWatch alarms to monitor ETL failures and cost thresholds

- ## Architecture Overview

The platform follows a batch-oriented cloud data pipeline designed for large-scale historical data exploration.

1. Raw H-1B and PERM datasets are stored in Amazon S3.
2. AWS Glue cleans, standardizes, and transforms the raw files.
3. Processed data is stored in Parquet format in S3.
4. Curated tables are loaded into Amazon RDS PostgreSQL via JDBC.
5. A Streamlit dashboard hosted on EC2 queries RDS and displays interactive insights.
6. An Application Load Balancer routes public traffic to the EC2-hosted dashboard.
7. CloudWatch monitors Glue jobs, EC2, RDS, S3 usage, and estimated AWS costs.

## Data Pipeline

The ETL process includes:

- Combining multi-year public datasets into unified source files
- Standardizing employer names for more consistent sponsor analysis
- Cleaning state, ZIP code, job title, wage, and industry-related fields
- Converting processed outputs into Parquet format for efficient storage
- Loading cleaned datasets into PostgreSQL tables for fast SQL-based querying
- Powering dashboard filters, charts, and employer-level search through RDS

## Dashboard Capabilities

The Streamlit dashboard allows users to explore:

- Employers with historical H-1B and PERM sponsorship activity
- Sponsorship trends by year, location, industry, and occupation
- Employer-level patterns across H-1B and PERM datasets
- Geographic and occupational differences in sponsorship behavior
- Query-ready summary views for job search and employer research

## Repository Structure

```text
visa-sponsorship-cloud-platform/
├── app/
│   └── app.py
├── etl/
│   ├── glue_transfrom_queries.sql
│   └── glue_s3_to_rds_loader.py
├── notebooks/
│   └── data_preparation_prior_to_s3.ipynb
├── sql/
│   └── schema_rds.sql
├── docs/
│   ├── screenshot_compilation.pdf
│   
└── README.md
