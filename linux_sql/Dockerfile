# Base image
FROM alpine:latest

# Install bash, cron, and PostgreSQL client
RUN apk add --no-cashe bash cronie postgresql-client

# Set working directory
WORKDIR /app

# Copy all linux_sql files
COPY . .

# Make scripts executable
RUN chmod +x scripts/*.sh

# Add cron job for host_usage.sh
RUN echo "* * * * * /app/scripts/host_usage.sh \$PGHOST \$PGPORT \$PGDATABASE \$PGUSER \$PGPASSWORD >> /tmp/host_usage.log 2>&1" > /etc/crontabs/root

# Run host_info.sh once, then start cron in foreground
CMD ["/bin/sh", "-c", "/app/scripts/host_info.sh \$PGHOST \$PGPORT \$PGDATABASE \$PGUSER \$PGPASSWORD && /usr/sbin/crond -f -L /tmp/cron.log"]