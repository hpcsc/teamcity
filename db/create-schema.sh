#!/bin/bash

DB_NAMES=( gogs artifactory )
for DB in ${DB_NAMES[@]} ; do
    echo "=== Creating schema for DB $DB"
    psql -v ON_ERROR_STOP=1 \
        --username "$POSTGRES_USER" <<-EOSQL
            CREATE DATABASE $DB;
            GRANT ALL PRIVILEGES ON DATABASE $DB TO $POSTGRES_USER;
EOSQL
done
