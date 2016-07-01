#!/bin/bash
set -e

export PGUSER="$POSTGRES_USER"

"${psql[@]}" <<- 'EOSQL'
CREATE DATABASE catalog_harvesting;
EOSQL

cd /etc/sqitch
sqitch deploy db:pg:catalog_harvesting
