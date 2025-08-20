# Base image
FROM alpine:latest

# Install bash, cron, and PostgreSQL client
RUN apk add --no-cache bash cronie postgresql-client procps util-linux

# Set working directory
WORKDIR /app

# Copy all linux_sql files
COPY . .

# Make scripts executable
RUN chmod +x scripts/*.sh

# Copy DDL file
COPY sql/ddl.sql /app/sql/ddl.sql

# Add cron job for host_usage.sh (runtime env vars)
RUN echo "* * * * * export PGHOST=$PGHOST PGPORT=$PGPORT PGDATABASE=$PGDATABASE PGUSER=$PGUSER PGPASSWORD=$PGPASSWORD && /bin/sh /app/scripts/host_usage.sh \$PGHOST \$PGPORT \$PGDATABASE \$PGUSER \$PGPASSWORD >> /tmp/host_usage.log 2>&1" > /etc/crontabs/root

# Run DDL, host_info.sh once, then start cron
CMD /bin/sh -c "\
  psql -h \$PGHOST -p \$PGPORT -U \$PGUSER -d \$PGDATABASE -f /app/sql/ddl.sql && \
  /app/scripts/host_info.sh \$PGHOST \$PGPORT \$PGDATABASE \$PGUSER \$PGPASSWORD && \
  /usr/sbin/crond -f \
"
