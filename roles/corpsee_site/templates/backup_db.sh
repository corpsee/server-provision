#!/bin/bash

CURRENT_DATE=$(date +%Y-%m-%d_%H-%M-%S)

mkdir -p -m 'u-x,go-x-w,u=rwX,go=rX' "${HOME}/backup"

COMMAND="pg_dump -O --column-inserts -F p -U {{ corpsee_site_db_user }} -d {{ corpsee_site_db_name }} -h localhost | grep -v -E '^(CREATE\ EXTENSION|COMMENT\ ON)' | gzip > ${HOME}/backup/{{ corpsee_site_db_name }}_${CURRENT_DATE}.sql.gz"
eval "${COMMAND}"
