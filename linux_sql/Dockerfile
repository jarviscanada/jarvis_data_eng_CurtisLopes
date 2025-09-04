# Base image
FROM alpine:latest

# Install bash, PostgreSQL client, and basic utilities
RUN apk add --no-cache bash postgresql-client procps util-linux

# Set working directory
WORKDIR /app

# Copy scripts and SQL files
COPY . .

# Make scripts executable
RUN chmod +x scripts/*.sh

# Copy DDL file
COPY sql/ddl.sql /app/sql/ddl.sql

# Run DDL and host_info.sh once, then keep container alive
CMD ["/bin/sh", "-c", "\
  echo 'Running DDL...'; \
  psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGDATABASE -f /app/sql/ddl.sql; \
  echo 'Running host_info.sh once...'; \
  /app/scripts/host_info.sh $PGHOST $PGPORT $PGDATABASE $PGUSER $PGPASSWORD; \
  echo 'Container ready. You can run host_usage.sh manually.'; \
  exec /bin/sh \
"]




