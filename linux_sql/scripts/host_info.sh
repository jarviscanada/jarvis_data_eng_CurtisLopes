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

# Parse host hardware specs and assign output to variables
hostname=$(hostname -f)
lscpu_out=`lscpu`
cpu_number=$(echo "$lscpu_out" | egrep "^CPU\(s\):" | awk '{print $2}' | xargs)
cpu_architecture=$(echo "$lscpu_out" | egrep "^\s*Architecture:" | awk '{print $2}' | xargs)
cpu_model=$(echo "$lscpu_out" | egrep "^\s*Model name:" | cut -d: -f2 | xargs)
cpu_mhz=$(grep "cpu MHz" /proc/cpuinfo | head -n1 | awk '{print $4}' | xargs)
l2_cache=$(lscpu | egrep "L2 cache:" | awk '{gsub(/[^0-9.]/, "", $3); print $3 * 1024}' | xargs)
total_mem=$(vmstat | tail -1 | awk '{print $4}')
timestamp=$(date "+%Y-%m-%d %H:%M:%S")

#INSERT statement from specification variables
insert_statement="INSERT INTO host_info (hostname, cpu_number, cpu_architecture, cpu_model, cpu_mhz, l2_cache, timestamp, total_mem)
VALUES ('$hostname', $cpu_number, '$cpu_architecture', '$cpu_model', $cpu_mhz, '$l2_cache', '$timestamp', $total_mem)
ON CONFLICT (hostname) DO NOTHING;"

#Execute INSERT statement
export PGPASSWORD=$psql_password
psql -h $psql_host -p $psql_port -d $db_name -U $psql_user -c "$insert_statement"

exit $?