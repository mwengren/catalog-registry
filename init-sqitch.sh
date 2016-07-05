#!/bin/bash
set -e

export PGUSER="$POSTGRES_USER"

"${psql[@]}" <<- 'EOSQL'
CREATE DATABASE catalog_harvesting;
EOSQL

cd /etc/sqitch

sqitch deploy db:pg://$POSGRES_USER@/$POSTGRES_DB
