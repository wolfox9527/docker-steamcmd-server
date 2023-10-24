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

if [ "${PUBLIC_IP}" == "auto" ]; then
  echo "---Trying to obtain public IP address automatically---"
  PUBLIC_IP="$(wget -qO - ipv4.icanhazip.com)"
  if [ -z "${PUBLIC_IP}" ]; then
    echo "---Can't get public IP, please specify your public IP manually in the variable PUBLIC_IP---"
    echo "---Putting container into sleep mode!---"
    sleep infinity
  else
    echo "---Success, got Public IP: ${PUBLIC_IP}---"
  fi
else
  echo "---Manually set Public IP: ${PUBLIC_IP}---"
fi

echo "---Prepare Server---"
echo "---Checking if config is in place---"
if [ ! -f ${SERVER_DIR}/TheFrontManager/ServerConfig_.ini ]; then
  echo "---No config file found, copying default config!---"
  mkdir -p ${SERVER_DIR}/TheFrontManager
  cp /opt/ServerConfig_.ini ${SERVER_DIR}/TheFrontManager/ServerConfig_.ini
else
  echo "---Config file found!"
fi

chmod -R ${DATA_PERM} ${DATA_DIR}
echo "---Server ready---"

echo "---Start Server---"
if [ ! -f ${SERVER_DIR}/ProjectWar/Binaries/Linux/TheFrontServer ]; then
  echo "---Something went wrong, can't find the executable, putting container into sleep mode!---"
  sleep infinity
else
  ${SERVER_DIR}/ProjectWar/Binaries/Linux/TheFrontServer ProjectWar_Start?DedicatedServer?${GAME_PARAMS} -server -game ${GAME_PARAMS_EXTRA} -log -OUTIPAddress=${PUBLIC_IP}
fi