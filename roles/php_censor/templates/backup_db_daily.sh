#!/usr/bin/env bash

CURRENT_DATE=$(date +%Y-%m-%d)
BACKUP_DIR="${HOME}/backup/{{ php_censor_dir_name }}"

mkdir --parents --mode='u-x,go-x-w,u=rwX,go=rX' "${BACKUP_DIR}"

COMMAND="pg_dump -O --column-inserts -F p -U {{ php_censor_db_user }} -d {{ php_censor_db_name }} -h 127.0.0.1 | grep -v -E '^(CREATE\ EXTENSION|COMMENT\ ON)' | xz > ${BACKUP_DIR}/{{ php_censor_db_name }}_${CURRENT_DATE}.sql.xz"
eval "${COMMAND}"
