#!/bin/bash
killpid="$(pidof rocketstation_DedicatedServer.x86_64)"
while true
do
	tail --pid=${killpid} --pid=${killpid} -f /dev/null
	kill "$(pidof tail)"
	exit 0
done