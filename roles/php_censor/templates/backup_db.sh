#!/bin/bash

CURRENT_DATE=`date +%Y-%m-%d`

COMMAND="pg_dump -O --column-inserts -F p -U {{ php_censor_db_user }} -d {{ php_censor_db_name }} -h localhost | grep -v -E '^(CREATE\ EXTENSION|COMMENT\ ON)' | gzip > ./backup/{{ php_censor_db_name }}_${CURRENT_DATE}.sql.gz"
eval "${COMMAND}"
