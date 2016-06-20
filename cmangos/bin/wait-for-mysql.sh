#!/bin/bash
while ! (echo "SELECT 1" | mysql -h $MYSQL_HOST -P $MYSQL_PORT -uroot -p$MYSQL_ROOT_PASSWORD); do sleep 1; done
$@
