#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# backup.sh
# Backup Confluence and PostgreSQL Docker volumes.
#
# Usage:
#   ./stop.sh       # Stop running containers
#   ./backup.sh     # Create tar.gz backups of both volumes
#
# Output:
#   confluence_data_backup_<timestamp>.tar.gz
#   postgres_data_backup_<timestamp>.tar.gz
#
# Note:
#   Containers must be stopped before backup.
# -----------------------------------------------------------------------------
set -e

# Volume names (adjust when project name changes)
CONF_VOL="example-confluence-app-with-docker-compose_confluence_data"
PG_VOL="example-confluence-app-with-docker-compose_postgres_data"

# Output directory
OUTDIR="$PWD"

# Timestamp
TS=$(date +%Y%m%d_%H%M%S)

echo "Backing up Confluence volume..."
docker run --rm \
  -v "$CONF_VOL:/data" \
  -v "$OUTDIR:/backup" \
  alpine \
  tar czvf "/backup/confluence_data_backup_${TS}.tar.gz" -C /data .

echo "Backing up PostgreSQL volume..."
docker run --rm \
  -v "$PG_VOL:/data" \
  -v "$OUTDIR:/backup" \
  alpine \
  tar czvf "/backup/postgres_data_backup_${TS}.tar.gz" -C /data .

echo "Backup completed successfully."
