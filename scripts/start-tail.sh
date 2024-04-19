#!/bin/bash
tail -n 100 -f ${DATA_DIR}/Steam/logs/steamcmd.log
sleep 5
killpid="$(pidof gotty)"
while true
do
  if [ -z "$killpid" ]; then
    kill $(pidof tail)
    exit 0
  fi
  tail --pid=$killpid -f /dev/null
  kill $(pidof tail)
  exit 0
done
