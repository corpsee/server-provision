#!/usr/bin/env bash

CURRENT_DATE=$(date +%Y-%m-%d)

mkdir --mode='u-x,go-x-w,u=rwX,go=rX' "${HOME}/backup"

COMMAND="pg_dump -O --column-inserts -F p -U {{ corpsee_site_db_user }} -d {{ corpsee_site_db_name }} -h 127.0.0.1 | grep -v -E '^(CREATE\ EXTENSION|COMMENT\ ON)' | gzip > ${HOME}/backup/{{ corpsee_site_db_name }}_${CURRENT_DATE}.sql.gz"
eval "${COMMAND}"
