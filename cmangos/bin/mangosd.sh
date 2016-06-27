#!/bin/bash
wait-for-mysql.sh
echo "# Append commands to this file to inject them into the mangosd service">>/commands
cd /runtime/bin
touch /log
function clearLog {
  while true; do
    echo>/log
    sleep 600
  done
}
clearLog&
tail -n 0 -f /commands | ./mangosd | tee /log
