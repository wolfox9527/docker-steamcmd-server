#!/bin/bash
while true
do
	sleep ${BACKUP_INTERVAL}m
	if [ -d ${SERVER_DIR}/User/Saves ]; then
		cd ${SERVER_DIR}/User/Saves
		tar -czf ${SERVER_DIR}/Backups/$(date '+%Y-%m-%d_%H.%M.%S').tar.gz .
	else
		echo "Backup ERROR: Save path ${SERVER_DIR}/User/Saves not found!"
	fi
	cd ${SERVER_DIR}/Backups
	ls -1tr ${SERVER_DIR}/Backups | sort | head -n -${BACKUP_TO_KEEP} | xargs -d '\n' rm -f --
	chmod -R ${DATA_PERM} ${SERVER_DIR}/Backups
done