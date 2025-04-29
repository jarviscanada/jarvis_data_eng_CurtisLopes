# Linux Cluster Monitoring Agent

# Introduction
This project implements a lightweight Linux monitoring agent that
collects hardware specifications and resource usage data from 
a host machine and stores it in a centralized PostgreSQL database.
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
## Scripts
## Database Modeling
The database, `host_data`, consists of two tables; `host_info` and `host_usage`. For each server, `host_info` stores static
hardware specifications, while `host_usage` stores dynamic performance metrics.

`host_info` stores the following information, all of which is assumed to stay constant:
- `id`:
- `hostname`:
- `cpu_number`:
- `cpu_architecture`:
- `cpu_model`:
- `cpu_mhz`:
- `l2_cache`:
- `timestamp`:
- `total_mem`:

`host_usage` stores the following information, with information being added every minute by each node
in order to keep resource usage information up-to-date and to track usage over time:
- `timestamp`:
- `host_id`:
- `memory_free`:
- `cpu_idle`:
- `cpu_kernel`:
- `disk_io`:
- `disk_available`:

# Test

# Deployment

# Improvements



