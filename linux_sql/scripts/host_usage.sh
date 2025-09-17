#!/bin/bash

# Setup arguments
psql_host=$1
psql_port=$2
db_name=$3
psql_user=$4
psql_password=$5

# Validate arguments
if [ "$#" -ne 5 ]; then
  echo "Illegal number of parameters"
  exit 1
fi

# Save machine stats in MB and current machine hostname to variables
vmstat_mb=$(vmstat --unit M)
vmstat_out=$(vmstat -t 1 2 | tail -1)
hostname=$(hostname -f)

# Retrieve hardware specification variables
memory_free=$(echo "$vmstat_mb" | awk '{print $4}' | tail -n1 | xargs)
cpu_idle=$(echo "$vmstat_out" | awk '{print $15}')
cpu_kernel=$(echo "$vmstat_out" | awk '{print $14}')
disk_io=$(vmstat --unit M -d | tail -1 | awk -v col="10" '{print $col}')
disk_available=$(df -BM / | tail -1 | awk '{print $4}' | sed 's/M//')
timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Query to find matching id in host_info table
host_id="(SELECT id FROM host_info WHERE hostname='$hostname')";

# PSQL insert statement
insert_statement="INSERT INTO host_usage (timestamp, host_id, memory_free, cpu_idle, cpu_kernel, disk_io, disk_available)
VALUES ('$timestamp', $host_id, $memory_free, $cpu_idle, $cpu_kernel, $disk_io, $disk_available);"

# Environment variable for psql cmd
export PGPASSWORD=$psql_password

# Execute insert statement
psql -h $psql_host -p $psql_port -d $db_name -U $psql_user -c "$insert_statement"

exit $?