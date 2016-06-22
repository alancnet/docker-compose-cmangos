#!/bin/bash
cd / && \
wait-for-mysql.sh && \
git clone $GITHUB_DATABASE classicdb && \
git clone $GITHUB_CMANGOS mangos && \
git clone $GITHUB_ACID acid && \
cp /InstallFullDB.config /classicdb/ && \
mysql -uroot -h $MYSQL_HOST -P $MYSQL_PORT -p$MYSQL_ROOT_PASSWORD < /mangos/sql/create/db_create_mysql.sql && \
mysql -uroot -h $MYSQL_HOST -P $MYSQL_PORT -p$MYSQL_ROOT_PASSWORD mangos < /mangos/sql/base/mangos.sql && \
mysql -uroot -h $MYSQL_HOST -P $MYSQL_PORT -p$MYSQL_ROOT_PASSWORD characters < /mangos/sql/base/characters.sql && \
mysql -uroot -h $MYSQL_HOST -P $MYSQL_PORT -p$MYSQL_ROOT_PASSWORD realmd < /mangos/sql/base/realmd.sql && \
pushd /classicdb && \
./InstallFullDB.sh && \
popd && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/ /acid /classicdb /mangos
echo Done.
