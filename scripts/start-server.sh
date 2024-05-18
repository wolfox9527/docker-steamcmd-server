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

sleep infinity

echo "---Prepare Server---"
if [ ! -f ${DATA_DIR}/.steam/sdk64/steamclient.so ]; then
	if [ ! -d ${DATA_DIR}/.steam/sdk64 ]; then
    	mkdir -p ${DATA_DIR}/.steam/sdk64
    fi
    cp -R ${STEAMCMD_DIR}/linux64/* ${DATA_DIR}/.steam/sdk64/
fi
if $(! grep "903950" ${SERVER_DIR}/Mist/Binaries/Linux/steam_appid.txt >/dev/null 2>&1) ; then
  echo "903950" > ${SERVER_DIR}/Mist/Binaries/Linux/steam_appid.txt
fi
chmod -R ${DATA_PERM} ${DATA_DIR}
echo "---Server ready---"

echo "---Start Server---"
cd ${SERVER_DIR}/Mist/Binaries/Linux
if [ -f ${SERVER_DIR}/Mist/Binaries/Linux/MistServer ]; then
  ./MistServer -log -force_steamclient_link -messaging -backendapiurloverride="${BACKENDAPIURLOVERRIDE}" -identifier="${IDENTIFIER}" -CustomerKey=${CUSTOMER_KEY} -ProviderKey=${PROVIDER_KEY} -slots=${SLOTS} -overrideconnectionaddress ${GAME_PARAMS}
elif [ -f ${SERVER_DIR}/Mist/Binaries/Linux/MistServer-Linux-Shipping ]; then
  ./MistServer-Linux-Shipping -log -force_steamclient_link -messaging -backendapiurloverride="${BACKENDAPIURLOVERRIDE}" -identifier="${IDENTIFIER}" -CustomerKey=${CUSTOMER_KEY} -ProviderKey=${PROVIDER_KEY} -slots=${SLOTS} -overrideconnectionaddress ${GAME_PARAMS}
else
  echo "---Something went wrong, can't find the executable, putting container into sleep mode!---"
  sleep infinity
fi