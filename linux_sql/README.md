# Linux Cluster Monitoring Agent

# Introduction
This project implements a lightweight Linux monitoring agent that
collects hardware specifications and resource usage data from 
a host machine (node) and stores it in a centralized PostgreSQL database.
The goal is to enable efficient infrastructure monitoring, providing visibility
into CPU, memory, and disk activity.

The primary users of this tool are system administrators and DevOps
engineers who need a way to collect and analyze a machine's data.

The monitoring agent has been built Bash scripts, and uses tools such as
`docker`, `psql`, and `crontab`. The project emphasizes modular scripting, automated scheduling,
and proper database design to handle dynamic data collection.

# Quick Start
```bash
# Start a PostgreSQL container
./scripts/psql_docker.sh start [db_username] [db_password]

# Create the necessary tables
psql -h localhost -U [db_username] -d host_agent -f ./sql/ddl.sql

# Collect and insert hardware specs (run once)
./scripts/host_info.sh localhost 5432 host_agent [db_username] [db_password]

# Collect and insert usage data (run every minute)
./scripts/host_usage.sh localhost 5432 host_agent [db_username] [db_password]

# Setup crontab (adds host_usage.sh to run every minute)
crontab -e
# Add the following line:
* * * * * bash ~/path/to/scripts/host_usage.sh localhost 5432 host_agent [db_username] [db_password]
```

# Implementation
## Architecture
![Cluster Diagram](./assets/cluster.png)
## Scripts
- `host_info.sh` is run once by each node in the cluster to gather hardware configuration information about the node
- `host_usage.sh` is run once every minute by the nodes in the cluster to collect up-to-date information
about a given node's usage
- `ddl.sql` is an SQL file that creates the database and tables in which the data will be stored
- `psql_docker.sh` is a scripts to start, stop, or create a PostGreSQL Docker container to store the data collected from the nodes in the cluster
## Database Modeling
The database, `host_data`, consists of two tables; `host_info` and `host_usage`. For each server, `host_info` stores static
hardware specifications, while `host_usage` stores dynamic performance metrics.

`host_info` stores the following information, all of which is assumed to stay constant:
- `id`: The unique id number which corresponds to a node. Serves as a primary key in 
the table and is auto-incremented by PostgreSQL
- `hostname`: Domain name of the node
- `cpu_number`: Number of CPUs
- `cpu_architecture`: CPU architecture
- `cpu_model`: CPU model name
- `cpu_mhz`: CPU clock speed in MHz
- `l2_cache`: Size of l2 cache in kB
- `timestamp`: Time of data collection
- `total_mem`: Total memory in kB

`host_usage` stores the following information, with information being added every minute by each node
in order to keep resource usage information up-to-date and to track usage over time:
- `timestamp`: Time of data collection
- `host_id`: id associated with node in host_info table
- `memory_free`: Free memory avaialble in MB
- `cpu_idle`: Percentage of idle CPU
- `cpu_kernel`: Percentage of CPU time spent in kernel mode
- `disk_io`: Dick I/O activity (number of write operations)
- `disk_available`: Available disk space in MB

# Test

# Deployment

# Improvements



