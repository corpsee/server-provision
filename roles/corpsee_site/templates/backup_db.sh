#!/bin/bash

CURRENT_DATE=`date +%Y-%m-%d`

COMMAND="pg_dump -O --column-inserts -F p -U {{ corpsee_site_db_user }} -d {{ corpsee_site_db_name }} -h localhost | gzip > ./backup/{{ corpsee_site_db_name }}_${CURRENT_DATE}.sql.gz"
eval "${COMMAND}"
