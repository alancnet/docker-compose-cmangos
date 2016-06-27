#!/bin/bash

function showFeedback {
  show=false
  while read line; do
    if [[ $line =~ "CLI command under processing..." ]]; then
      show=true
      echo
    elif [[ $line =~ "mangos>" ]]; then
      show=false
      echo -n "mangos>"
    elif $show; then
      echo $line
    fi
  done
}

function sendCommands {
  while read -p "mangos>" line; do
    echo "$line" >> /commands
  done
}

(tail -f /log | showFeedback) & sendCommands && fg