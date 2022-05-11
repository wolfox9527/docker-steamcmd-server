#!/bin/bash
killpid="$(pidof CoreKeeperServer)"
while true
do
	tail --pid=$killpid -f /dev/null
	kill $(pidof sleep)
exit 0
done