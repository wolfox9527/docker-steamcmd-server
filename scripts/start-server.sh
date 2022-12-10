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
echo "---Looking if Server config is in place---"
if [ ! -d "$SERVER_DIR/.local/share/Euro Truck Simulator 2" ]; then
  mkdir -p "$SERVER_DIR/.local/share/Euro Truck Simulator 2"
fi
if [ ! -f "$SERVER_DIR/.local/share/Euro Truck Simulator 2/server_packages.dat" ]; then
  echo "---Server config not found, copying default...---"
  tar -C "$SERVER_DIR/.local/share/Euro Truck Simulator 2" -xvf /opt/config.tar
else
  echo "---Server config found!---"
fi

if [ ! -f ${SERVER_DIR}/.steam/sdk64/steamclient.so ]; then
	if [ ! -d ${SERVER_DIR}/.steam/sdk64 ]; then
    	mkdir -p ${SERVER_DIR}/.steam/sdk64
    fi
    cp -R ${STEAMCMD_DIR}/linux64/* ${SERVER_DIR}/.steam/sdk64/
fi
chmod -R ${DATA_PERM} ${DATA_DIR}
echo "---Server ready---"

echo "---Start Server---"
export LD_LIBRARY_PATH=$SERVER_DIR/linux64
cd ${SERVER_DIR}/bin/linux_x64
${SERVER_DIR}/bin/linux_x64/eurotrucks2_server ${GAME_PARAMS}