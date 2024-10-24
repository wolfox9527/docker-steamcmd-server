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
fi

if [ -d ${SERVER_DIR}/.git ]; then
  if [ -d ${SERVER_DIR}/Longvinter/Saved ]; then
    echo "Found old folder structure, migrating to new folder stucture!"
    echo "Please don't interrupt this process since this can lead to data loss!"
    cp -R ${SERVER_DIR}/Longvinter/Saved /tmp/
    echo "Backing up save game, please wait..."
    rm -rf ${SERVER_DIR}/* ${SERVER_DIR}/.*
    echo "Done!"
  fi
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

if [ -d /tmp/Saved ]; then
  echo "Restoring savegame, please wait..."
  cp -R /tmp/Saved ${SERVER_DIR}/Longvinter/
  rm -rf /tmp/Saved
  echo "Done!"
fi

echo "---Prepare Server---"
if [ ! -f ${DATA_DIR}/.steam/sdk64/steamclient.so ]; then
  if [ ! -d ${DATA_DIR}/.steam/sdk64 ]; then
    mkdir -p ${DATA_DIR}/.steam/sdk64
  fi
  cp -R ${STEAMCMD_DIR}/linux64/* ${DATA_DIR}/.steam/sdk64/
fi
if [ ! -f ${SERVER_DIR}/Longvinter/Saved/Config/LinuxServer/Game.ini ]; then
    echo "---No config file found, creating...---"
    echo "[/Game/Blueprints/Server/GI_AdvancedSessions.GI_AdvancedSessions_C]
ServerName=Longvinter Docker
MaxPlayers=32
ServerMOTD=Welcome to Longvinter running in Docker!
Password=Docker
CommunityWebsite=unraid.net

[/Game/Blueprints/Server/GM_Longvinter.GM_Longvinter_C]
AdminSteamID=" > ${SERVER_DIR}/Longvinter/Saved/Config/LinuxServer/Game.ini
fi
chmod -R ${DATA_PERM} ${DATA_DIR}
chmod +x ${SERVER_DIR}/Longvinter/Binaries/Linux/LongvinterServer-Linux-Shipping
echo "---Server ready---"

echo "---Start Server---"
cd ${SERVER_DIR}
${SERVER_DIR}/Longvinter/Binaries/Linux/LongvinterServer-Linux-Shipping Longvinter -Port=${GAME_PORT} ${GAME_PARAMS}