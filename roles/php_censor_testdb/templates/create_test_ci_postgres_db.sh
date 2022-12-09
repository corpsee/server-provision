#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

BUILD_ID="$1"
test -n "$1" || exit 1;

sudo -u postgres psql --echo-all --command="CREATE DATABASE \"{{ php_censor_testdb_postgres_db_name }}_${BUILD_ID}\";"
sudo -u postgres psql --echo-all --command="GRANT ALL PRIVILEGES ON DATABASE \"{{ php_censor_testdb_postgres_db_name }}_${BUILD_ID}\" TO \"{{ php_censor_testdb_postgres_db_user }}\";"

exit 0;
