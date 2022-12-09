#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

BUILD_ID="$1"
test -n "$1" || exit 1;

sudo mysql --host="127.0.0.1" --verbose --execute="CREATE DATABASE IF NOT EXISTS \`{{ php_censor_testdb_mysql_db_name }}_${BUILD_ID}\`;"
sudo mysql --host="127.0.0.1" --verbose --execute="GRANT ALL ON {{ php_censor_testdb_mysql_db_name }}_${BUILD_ID}.* TO '{{ php_censor_testdb_mysql_db_user }}'@'localhost';"
sudo mysql --host="127.0.0.1" --verbose --execute="FLUSH PRIVILEGES;"

exit 0;
