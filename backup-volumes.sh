docker run --rm \
  -v example-confluence-app-with-docker-compose_confluence_data:/data \
  -v $PWD:/backup \
  alpine \
  tar czvf /backup/confluence_data_backup_$(date +%Y%m%d_%H%M%S).tar.gz -C /data .


docker run --rm \
  -v example-confluence-app-with-docker-compose_postgres_data:/data \
  -v $PWD:/backup \
  alpine \
  tar czvf /backup/postgres_data_backup_$(date +%Y%m%d_%H%M%S).tar.gz -C /data .
