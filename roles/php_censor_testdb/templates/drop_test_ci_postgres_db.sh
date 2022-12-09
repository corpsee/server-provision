#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

BUILD_ID="$1"
test -n "$1" || exit 1;

sudo -u postgres psql --echo-all --command="DROP DATABASE \"{{ php_censor_testdb_postgres_db_name }}_${BUILD_ID}\";"

exit 0;
