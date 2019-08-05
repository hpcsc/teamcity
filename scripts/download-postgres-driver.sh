#!/bin/bash

DRIVER_VERSION=42.2.6

mkdir -p ./server/data/lib/jdbc/

curl https://jdbc.postgresql.org/download/postgresql-${DRIVER_VERSION}.jar -o ./server/data/lib/jdbc/postgres.jar
