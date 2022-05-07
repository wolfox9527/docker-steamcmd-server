#!/bin/bash
if [ "${FORCE_X64}" == "true" ]; then
  killpid="$(pidof dontstarve_dedicated_server_nullrenderer)"
else
  killpid="$(pidof dontstarve_dedicated_server_nullrenderer_x64)"
fi
while true
do
	tail --pid=${killpid%% *} --pid=${killpid##* } -f /dev/null
	kill "$(pidof tail)"
	exit 0
done