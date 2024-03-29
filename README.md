# ELT project

This repository contains a custom Extract, Transform , Load (ETL) project that utilizes Docker,  Airflow, DBT, and PostgreSQL to demonstrate a simple ETL process.

## Repository Structure

1. **docker-compose.yaml**: This file contains the configuration for Docker Compose, which is used to orchestrate multiple Docker containers ,  It defines multiple services:
   - `source_postgres`: The source PostgreSQL database running on port 5433.
   - `destination_postgres`: The destination PostgreSQL database running on port 5434.
   - `postgres`: The postgres database used to store metadata from Airflow.
   - `webserver`: The Web UI for Airflow.
   - `scheduler`: Airflow's scheduler to orchestrate your tasks.
all these containers run in one network called etl_network.

2. **airflow**: This folder contains the Airflow DAG including the tasks to orchestrate both etl_script and DBT to complete the ETL workflow
   
3.**custom-postgres**: Has all the models needed for correctedness of data and tranformations need to be done on the data .

4. **etl**: has the etl_script stored along with Docker file for CRON jobs .

5. **source_db_init/init.sql**: This SQL script initializes the source database with sample data. It creates tables for users, films, film categories, actors, and film actors, and inserts sample data into these tables.

## How It Works

1. **Docker Compose**: Using the `docker-compose.yaml` file, a couple Docker containers are spun up:
   - A source PostgreSQL database with sample data.
   - A destination PostgreSQL database.
   - A Postgres database to store Airflow metadata
   - The webserver to access Airflow throught the UI
   - Airflow's Scheduler

2. **Database Initialization**: The `init.sql` script initializes the source database with sample data. It creates several tables and populates them with sample data.

3. **ETL Process**:  Airflow will run the etl_script to transfer data from source_postgres to destination_postgres   and then DBT to run the transformations on top of the destination database.

## Airflow DAG Description

This Airflow DAG orchestrates a simple ETL process using Docker, Airflow, DBT, and PostgreSQL. The DAG consists of two tasks:

1. **Run ETL Script Task**: This task executes an ETL script (`etl_script.py`) that transfers data from a source PostgreSQL database to a destination PostgreSQL database. The script is responsible for extracting data from the source, transforming it as necessary, and loading it into the destination.

2. **Run DBT Task**: This task utilizes the `dbt-postgres` Docker image to run DBT (data build tool) transformations on the destination PostgreSQL database. DBT is used to perform data modeling, validation, and other transformations on the data loaded by the ETL script.

### How It Works

1. **Initialization**: Docker Compose is used to spin up several Docker containers, including the source PostgreSQL database with sample data, the destination PostgreSQL database, a Postgres database to store Airflow metadata, the Airflow webserver for UI access, and the Airflow scheduler.

2. **Database Initialization**: The `init.sql` script initializes the source database with sample data, creating tables for users, films, film categories, actors, and film actors, and populating them with sample data.

3. **ETL Process**: The DAG triggers the execution of the ETL script task, which transfers data from the source to the destination database. Once this task completes successfully, the DBT task is triggered to run transformations on the destination database.

