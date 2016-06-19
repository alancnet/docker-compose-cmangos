#!/bin/bash
wait-for-mysql.sh && \
mysql -uroot -h $MYSQL_HOST -P $MYSQL_PORT -p$MYSQL_ROOT_PASSWORD < /mangos/sql/create/db_create_mysql.sql && \
mysql -uroot -h $MYSQL_HOST -P $MYSQL_PORT -p$MYSQL_ROOT_PASSWORD mangos < /mangos/sql/base/mangos.sql && \
mysql -uroot -h $MYSQL_HOST -P $MYSQL_PORT -p$MYSQL_ROOT_PASSWORD characters < /mangos/sql/base/characters.sql && \
mysql -uroot -h $MYSQL_HOST -P $MYSQL_PORT -p$MYSQL_ROOT_PASSWORD realmd < /mangos/sql/base/realmd.sql && \
pushd /classicdb && \
./InstallFullDB.sh && \
popd && \
echo Done.
