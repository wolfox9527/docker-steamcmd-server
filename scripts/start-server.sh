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
        +force_install_dir ${SERVER_DIR} \
        +login anonymous \
        +app_update ${GAME_ID} validate \
        +quit
    else
        ${STEAMCMD_DIR}/steamcmd.sh \
        +force_install_dir ${SERVER_DIR} \
        +login anonymous \
        +app_update ${GAME_ID} \
        +quit
    fi
else
    if [ "${VALIDATE}" == "true" ]; then
    	echo "---Validating installation---"
        ${STEAMCMD_DIR}/steamcmd.sh \
        +force_install_dir ${SERVER_DIR} \
        +login ${USERNAME} ${PASSWRD} \
        +app_update ${GAME_ID} validate \
        +quit
    else
        ${STEAMCMD_DIR}/steamcmd.sh \
        +force_install_dir ${SERVER_DIR} \
        +login ${USERNAME} ${PASSWRD} \
        +app_update ${GAME_ID} \
        +quit
    fi
fi

echo "---Prepare Server---"
if [ ! -f ${DATA_DIR}/.steam/sdk64/steamclient.so ]; then
  if [ ! -d ${DATA_DIR}/.steam/sdk64 ]; then
    mkdir -p ${DATA_DIR}/.steam/sdk64
  fi
  cp -R ${STEAMCMD_DIR}/linux64/* ${DATA_DIR}/.steam/sdk64/
fi
echo "---Checking for old display lock files---"
find /tmp -name ".X99*" -exec rm -f {} \; > /dev/null 2>&1
echo "---Checking for old logfiles---"
find ${SERVER_DIR} -name "XvfbLog.*" -exec rm -f {} \; > /dev/null 2>&1
chmod +x ${SERVER_DIR}/CoreKeeperServer
if [ -f ${SERVER_DIR}/steamclient.so ]; then
  rm ${SERVER_DIR}/steamclient.so
fi
echo "---Server ready---"
sleep infinity
echo "---Starting Xvfb server---"
screen -S Xvfb -L -Logfile ${SERVER_DIR}/XvfbLog.0 -d -m /opt/scripts/start-Xvfb.sh
sleep 3

echo "---Start Server---"
export DISPLAY=:99
cd ${SERVER_DIR}
${SERVER_DIR}/CoreKeeperServer -batchmode -logfile ${SERVER_DIR}/CoreKeeperServerLog.txt -world ${WORLD_INDEX} -worldname "${WORLD_NAME}" -datapath "${SERVER_DIR}/Save" ${GAME_PARAMS}