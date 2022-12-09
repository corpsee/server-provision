#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

BUILD_ID="$1"
test -n "$1" || exit 1;

sudo mysql --host="127.0.0.1" --verbose --execute="DROP DATABASE IF EXISTS \`{{ php_censor_testdb_mysql_db_name }}_${BUILD_ID}\`;"

exit 0;
