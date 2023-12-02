# Use the official Apache Airflow image as the base
FROM apache/airflow:2.5.0

# Set environment variables
ENV AIRFLOW_HOME=/opt/airflow
ARG AIRFLOW_VERSION=2.5.0

# Switch to the 'airflow' user
USER airflow

# Install Apache Airflow and its dependencies as the 'airflow' user
RUN pip install --no-cache-dir "apache-airflow==${AIRFLOW_VERSION}" pandas sqlalchemy psycopg2-binary

# Continue with other Dockerfile commands if needed
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Switch back to the 'root' user for other installations
USER root

# Install additional packages as needed
RUN apt-get update -qq && apt-get install -y vim

# Set the shell for the following commands
SHELL ["/bin/bash", "-o", "pipefail", "-e", "-u", "-x", "-c"]


# Set the working directory for Apache Airflow
WORKDIR $AIRFLOW_HOME



# Set the user to the 'airflow' user defined in the base image
USER $AIRFLOW_UID
