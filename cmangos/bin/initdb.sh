#!/bin/bash
apt-get update && \
apt-get install -y mysql-client git-core && \
wait-for-mysql.sh && \
git clone $GITHUB_CMANGOS mangos
git clone $GITHUB_ACID acid && \
git clone $GITHUB_DATABASE classicdb && \
cp /InstallFullDB.sh /classicdb/ && \
mysql -uroot -h $MYSQL_HOST -P $MYSQL_PORT -p$MYSQL_ROOT_PASSWORD < /mangos/sql/create/db_create_mysql.sql && \
mysql -uroot -h $MYSQL_HOST -P $MYSQL_PORT -p$MYSQL_ROOT_PASSWORD mangos < /mangos/sql/base/mangos.sql && \
mysql -uroot -h $MYSQL_HOST -P $MYSQL_PORT -p$MYSQL_ROOT_PASSWORD characters < /mangos/sql/base/characters.sql && \
mysql -uroot -h $MYSQL_HOST -P $MYSQL_PORT -p$MYSQL_ROOT_PASSWORD realmd < /mangos/sql/base/realmd.sql && \
pushd /classicdb && \
./InstallFullDB.sh && \
popd && \
apt-get remove -y mysql-client git-core && \
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/ /acid /classicdb /mangos
echo Done.
