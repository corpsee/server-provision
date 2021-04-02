#!/usr/bin/env bash

CURRENT_DATE=$(date +%Y-%m-%d)

mkdir --mode='u-x,go-x-w,u=rwX,go=rX' "${HOME}/backup"

COMMAND="pg_dump -O --column-inserts -F p -U {{ php_censor_db_user }} -d {{ php_censor_db_name }} -h 127.0.0.1 | grep -v -E '^(CREATE\ EXTENSION|COMMENT\ ON)' | xz > ${HOME}/backup/{{ php_censor_db_name }}_${CURRENT_DATE}.sql.xz"
eval "${COMMAND}"
