#!/bin/bash
if [ ! -f ${STEAMCMD_DIR}/steamcmd.sh ]; then
    echo "SteamCMD not found!"
    wget -q -O ${STEAMCMD_DIR}/steamcmd_linux.tar.gz http://media.steampowered.com/client/steamcmd_linux.tar.gz 
    tar --directory ${STEAMCMD_DIR} -xvzf /serverdata/steamcmd/steamcmd_linux.tar.gz
    rm ${STEAMCMD_DIR}/steamcmd_linux.tar.gz
fi

echo "---Update SteamCMD---"
if [ "${USERNAME}" == "" ]; then
    ${STEAMCMD_DIR}/steamcmd.sh \
    +login anonymous \
    +quit
else
    ${STEAMCMD_DIR}/steamcmd.sh \
    +login ${USERNAME} ${PASSWRD} \
    +quit
fi

echo "---Update Server---"
if [ "${USERNAME}" == "" ]; then
    if [ "${VALIDATE}" == "true" ]; then
    	echo "---Validating installation---"
        ${STEAMCMD_DIR}/steamcmd.sh \
        +@sSteamCmdForcePlatformType windows \
        +force_install_dir ${SERVER_DIR} \
        +login anonymous \
        +app_update ${GAME_ID} validate \
        +quit
    else
        ${STEAMCMD_DIR}/steamcmd.sh \
        +@sSteamCmdForcePlatformType windows \
        +force_install_dir ${SERVER_DIR} \
        +login anonymous \
        +app_update ${GAME_ID} \
        +quit
    fi
else
    if [ "${VALIDATE}" == "true" ]; then
    	echo "---Validating installation---"
        ${STEAMCMD_DIR}/steamcmd.sh \
        +@sSteamCmdForcePlatformType windows \
        +force_install_dir ${SERVER_DIR} \
        +login ${USERNAME} ${PASSWRD} \
        +app_update ${GAME_ID} validate \
        +quit
    else
        ${STEAMCMD_DIR}/steamcmd.sh \
        +@sSteamCmdForcePlatformType windows \
        +force_install_dir ${SERVER_DIR} \
        +login ${USERNAME} ${PASSWRD} \
        +app_update ${GAME_ID} \
        +quit
    fi
fi

echo "---Prepare Server---"
export WINEARCH=win64
export WINEPREFIX=/serverdata/serverfiles/WINE64
export DISPLAY=:99
echo "---Checking if WINE workdirectory is present---"
if [ ! -d ${SERVER_DIR}/WINE64 ]; then
	echo "---WINE workdirectory not found, creating please wait...---"
    mkdir ${SERVER_DIR}/WINE64
else
	echo "---WINE workdirectory found---"
fi
echo "---Checking if WINE is properly installed---"
if [ ! -d ${SERVER_DIR}/WINE64/drive_c/windows ]; then
	echo "---Setting up WINE---"
    cd ${SERVER_DIR}
    winecfg > /dev/null 2>&1
    sleep 15
else
	echo "---WINE properly set up---"
fi

echo "---Checking if database is in place---"
if [ ! -d ${SERVER_DIR}/.database ]; then
  echo "---Database not found, setting up databbase...---"
  mkdir -p ${SERVER_DIR}/.database
  cp -R /var/lib/mysql/* ${SERVER_DIR}/.database/
else
  echo "---Database found---"
fi

echo "---Checking if database configuration is in place---"
if [ ! -f ${SERVER_DIR}/config_local.cs ]; then
  echo "---Database configuration not found, configuring...---"
  cp ${SERVER_DIR}/docs/config_local.cs ${SERVER_DIR}/config_local.cs
  sed -i 's/\<root\>/steam/g' ${SERVER_DIR}/config_local.cs
  sed -i 's/\<rootPassword\>/lifyo/g' ${SERVER_DIR}/config_local.cs
else
  echo "---Database connection found---"
fi

echo "---Starting MariaDB---"
screen -S MariaDB -d -m mysqld_safe
sleep 2

echo "---Starting Xvfb---"
screen -S Xvfb -d -m /opt/scripts/start-Xvfb.sh
sleep 2

echo "---Checking for old display lock files---"
find /tmp -name ".X99*" -exec rm -f {} \; > /dev/null 2>&1
chmod -R ${DATA_PERM} ${DATA_DIR}
echo "---Server ready---"

sleep infinity

echo "---Start Server---"
if [ ! -f ${SERVER_DIR}/ddctd_cm_yo_server.exe ]; then
  echo "---Something went wrong, can't find the executable, putting container into sleep mode!---"
  sleep infinity
else
  cd ${SERVER_DIR}
  screen -S LiFYO -d -m wine64 ddctd_cm_yo_server.exe ${GAME_PARAMS}
  echo "---Waiting for logs...---"
  sleep 3
  /opt/scripts/start-watchdog.sh &
  cd ${SERVER_DIR}/logs
  cd $(ls -1d */ | tail -1)
  tail -n 9999 -f $(ls -t | head -n 1)
fi