#!/bin/bash
set -e

dname="/data/"
rm -rf "$dname"
mkdir "$dname"
echo 'RS----------------- Downloading database file...'
curl "$1" | zcat > "${dname}restore-me.sql"
echo 'RS----------------- Downloaded database file'


echo 'RS----------------- Restoring database...'
PGHOST="$POSTGRES_PORT_5432_TCP_ADDR" \
PGPORT="$POSTGRES_PORT_5432_TCP_PORT" \
PGUSER="$POSTGRES_ENV_POSTGRES_USER" \
PGPASSWORD="$POSTGRES_ENV_POSTGRES_PASSWORD" \
pg_restore -Fc --no-owner --dbname "$DBNAME" -h "$PGHOST" -p "$PGPORT" -U "$PGUSER" -w "${dname}restore-me.sql"
echo 'RS----------------- Restored!'
# rm -rf "$dname"
