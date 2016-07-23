#!/bin/bash
function import {
  database=$1
  shift
  while ! [ -z "$1" ]; do
    (ls "$1") | \
    while read line; do 
      echo "Importing $line" && \
      mysql -uroot -h $MYSQL_HOST -P $MYSQL_PORT -p$MYSQL_ROOT_PASSWORD $database < "$line" 
    done
    shift
  done
}

cd / && \
wait-for-mysql.sh && \
git clone $GITHUB_DATABASE tbc-db && \
git clone -b $GITHUB_CMANGOS_BRANCH --single-branch $GITHUB_CMANGOS mangos && \
git clone $GITHUB_ACID acid && \
import mysql /mangos/sql/create/db_create_mysql.sql && \
import mangos /mangos/sql/base/mangos.sql && \
import characters /mangos/sql/base/characters.sql /mangos/sql/updates/characters/*.sql && \
import realmd /mangos/sql/base/realmd.sql /mangos/sql/updates/realmd/*.sql && \
import mangos /tbc-db/Current_Release/Full_DB/*.sql /tbc-db/Updates/*.sql /acid/*.sql /mangos/sql/updates/mangos/*.sql && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/ /acid /tbc-db /mangos && \
echo Done.
