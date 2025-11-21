#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# restore.sh
# Restore Confluence and PostgreSQL volumes from backup tar.gz files.
#
# Usage:
#   ./stop.sh       # Stop containers (must not be running)
#   ./reset.sh      # Remove existing volumes (down -v)
#   ./restore.sh    # Restore latest backup files into fresh volumes
#   ./run.sh        # Start Confluence with restored data
#
# Note:
#   "reset.sh" must be executed before restore.sh.
#   restore.sh automatically uses the latest backup files:
#       confluence_data_backup_*.tar.gz
#       postgres_data_backup_*.tar.gz
# -----------------------------------------------------------------------------
set -e

# Volume names (adjust when project name changes)
CONF_VOL="confluence-docker-sandbox_confluence_data"
PG_VOL="confluence-docker-sandbox_postgres_data"

# Find latest backup files
CONF_BKP=$(ls -1t confluence_data_backup_*.tar.gz | head -1)
PG_BKP=$(ls -1t postgres_data_backup_*.tar.gz | head -1)

if [[ -z "$CONF_BKP" || -z "$PG_BKP" ]]; then
  echo "No backup files found. Aborting."
  exit 1
fi

echo "Using backup files:"
echo "  Confluence: $CONF_BKP"
echo "  PostgreSQL: $PG_BKP"
echo ""

echo "Restoring Confluence volume..."
docker run --rm \
  -v "$CONF_VOL:/data" \
  -v "$PWD:/backup" \
  alpine \
  sh -c "cd /data && tar xzvf /backup/$CONF_BKP"

echo "Restoring PostgreSQL volume..."
docker run --rm \
  -v "$PG_VOL:/data" \
  -v "$PWD:/backup" \
  alpine \
  sh -c "cd /data && tar xzvf /backup/$PG_BKP"

echo "Restore completed."
