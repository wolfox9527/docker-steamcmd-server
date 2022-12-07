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
echo "---Looking if World is already in place---"
if [ ! -d ${SERVER_DIR}/PlayfulCorp/CreativerseServer/worlddata/worlds ]; then
  mkdir -p ${SERVER_DIR}/PlayfulCorp/CreativerseServer/worlddata/worlds
fi
WORLD_NAME="$(grep -oE '\-worldId\S+' <<< ${GAME_PARAMS})"
if [ "${WORLD_NAME#*=}" == "unraid_world" ]; then
  if [ ! -d ${SERVER_DIR}/PlayfulCorp/CreativerseServer/worlddata/worlds/unraid_world ]; then
    echo "---Default world 'unraid_world' not found, please wait, installing...---"
    mkdir -p ${SERVER_DIR}/PlayfulCorp/CreativerseServer/worlddata/worlds/unraid_world
    tar -C ${SERVER_DIR}/PlayfulCorp/CreativerseServer/worlddata/worlds/unraid_world -xvf /opt/world.tar
  else
    echo "---Default world 'unraid_world' found!---"
  fi
else
  if [ ! -d ${SERVER_DIR}/PlayfulCorp/CreativerseServer/worlddata/worlds/${WORLD_NAME#*=} ]; then
    echo
    echo "+-------------------------------------------------------------------------------"
    echo "| World '${WORLD_NAME#*=}' not found, please copy it over to:"
    echo "| '.../PlayfulCorp/CreativerseServer/worlddata/worlds/${WORLD_NAME#*=}'"
    echo "| and restart the container!"
    echo "|"
    echo "| Putting Container into sleep mode!"
    echo "+-------------------------------------------------------------------------------"
    chmod -R ${DATA_PERM} ${SERVER_DIR}/PlayfulCorp
    sleep infinity
  else
    echo "---World '${WORLD_NAME#*=}' found!---"
  fi
fi  
chmod -R ${DATA_PERM} ${DATA_DIR}
echo "---Server ready---"

echo "---Start Server---"
cd ${SERVER_DIR}
${SERVER_DIR}/CreativerseServer ${GAME_PARAMS}