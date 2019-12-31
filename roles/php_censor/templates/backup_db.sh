#!/bin/bash

CURRENT_DATE=$(date +%Y-%m-%d_%H-%M-%S)

mkdir -p -m 'u-x,go-x-w,u=rwX,go=rX' "${HOME}/backup"

COMMAND="pg_dump -O --column-inserts -F p -U {{ php_censor_db_user }} -d {{ php_censor_db_name }} -h 127.0.0.1 | grep -v -E '^(CREATE\ EXTENSION|COMMENT\ ON)' | gzip > ${HOME}/backup/{{ php_censor_db_name }}_${CURRENT_DATE}.sql.gz"
eval "${COMMAND}"
