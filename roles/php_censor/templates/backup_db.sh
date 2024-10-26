#!/usr/bin/env bash

BACKUP_DIR="${HOME}/backup/{{ php_censor_dir_name }}"

CURRENT_DATE=$(date +%Y-%m-%d)
DAY_OF_MONTH=$(date +%d)
DAY_OF_WEEK=$(date +%u) #1-7 (Monday-Sunday)

DAYS_TO_KEEP=14
WEEKS_TO_KEEP=8
MONTHS_TO_KEEP=6

mkdir --parents --mode='u-x,go-x-w,u=rwX,go=rX' "${BACKUP_DIR}"

function perform_backups()
{
    SUFFIX=$1

    if [ ! -f "${BACKUP_DIR}/{{ php_censor_db_name }}_${CURRENT_DATE}_${SUFFIX}.sql.xz" ];
    then
        COMMAND="pg_dump -O --column-inserts -F p -U {{ php_censor_db_user }} -d {{ php_censor_db_name }} -h 127.0.0.1 | grep -v -E '^(CREATE\ EXTENSION|COMMENT\ ON)' | xz > ${BACKUP_DIR}/{{ php_censor_db_name }}_${CURRENT_DATE}_${SUFFIX}.sql.xz"
        eval "${COMMAND}"
    fi
}

# MONTHLY BACKUPS

EXPIRED_DAYS_MONTHLY=$((MONTHS_TO_KEEP * 30 + 1))
if [ "${DAY_OF_MONTH}" -eq 1 ]; # Start on first month day
then
    # Delete all expired monthly directories
    find "${BACKUP_DIR}" -maxdepth 1 -mtime +$EXPIRED_DAYS_MONTHLY -name "*_monthly.sql.xz" -exec rm -rf '{}' ';'

    perform_backups "monthly"
fi

# WEEKLY BACKUPS

EXPIRED_DAYS_WEEKLY=$((WEEKS_TO_KEEP * 7 + 1))
if [ "${DAY_OF_WEEK}" = 1 ]; # Start on monday
then
    # Delete all expired weekly directories
    find "${BACKUP_DIR}" -maxdepth 1 -mtime +$EXPIRED_DAYS_WEEKLY -name "*_weekly.sql.xz" -exec rm -rf '{}' ';'

    perform_backups "weekly"
fi

# DAILY BACKUPS

# Delete daily backups DAYS_TO_KEEP days old or more
find "${BACKUP_DIR}" -maxdepth 1 -mtime +$DAYS_TO_KEEP -name "*_daily.sql.xz" -exec rm -rf '{}' ';'

perform_backups "daily"
