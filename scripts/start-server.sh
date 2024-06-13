#!/bin/bash
if [ ! -f ${STEAMCMD_DIR}/steamcmd.sh ]; then
  echo "SteamCMD not found!"
  wget -q -O ${STEAMCMD_DIR}/steamcmd_linux.tar.gz http://media.steampowered.com/client/steamcmd_linux.tar.gz 
  tar --directory ${STEAMCMD_DIR} -xvzf /serverdata/steamcmd/steamcmd_linux.tar.gz
  rm ${STEAMCMD_DIR}/steamcmd_linux.tar.gz
fi

echo "---Update SteamCMD---"
${STEAMCMD_DIR}/steamcmd.sh \
  +login anonymous \
  +quit


echo "---Update Server---"
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

echo "---Prepare Server---"
if [ ! -d ${DATA_DIR}/.steam/sdk64 ]; then
  mkdir -p ${DATA_DIR}/.steam/sdk64
  cp -R ${SERVER_DIR}/linux64/* ${DATA_DIR}/.steam/sdk64/
  echo "---Server ready---"
else
  echo "---Server ready---"
fi
chmod -R ${DATA_PERM} ${DATA_DIR}
   
echo "---Start Server---"
cd ${SERVER_DIR}
if [ ! -f ${SERVER_DIR}/WS/Binaries/Linux/WSServer-Linux-Shipping ]; then
  echo "---Something went wrong, can't find the executable, putting container into sleep mode!---"
  sleep infinity
else
  ${SERVER_DIR}/WS/Binaries/Linux/WSServer-Linux-Shipping WS ${MAP} -server ${GAME_PARAMS} -log -UTF8Output -MULTIHOME=0.0.0.0 -forcepassthrough
fi