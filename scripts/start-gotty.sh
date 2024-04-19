#!/bin/bash
TERM=linux gotty ${GOTTY_PARAMS} screen -xS steamcmd &
killpid="$(pgrep screen)"
while true
do
  tail --pid=$killpid -f /dev/null
  kill "$(pidof gotty)"
  exit 0
done
