#!/bin/bash
wait-for-mysql.sh
echo "# Append commands to this file to inject them into the mangosd service">>/commands
cd /mangos/run/bin
tail -n 0 -f /commands | ./mangosd
