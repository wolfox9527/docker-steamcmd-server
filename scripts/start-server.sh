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

echo "Under construction, sleep zZzZzZzZz..."
sleep infinity

echo "---Prepare Server---"
chmod -R ${DATA_PERM} ${DATA_DIR}
echo "---Server ready---"

echo "---Start Server---"
if [ ! -f ${SERVER_DIR}/ShooterGame/Binaries/Win64/ArkAscendedServer.exe ]; then
  echo "---Something went wrong, can't find the executable, putting container into sleep mode!---"
  sleep infinity
else
  cd ${SERVER_DIR}/ShooterGame/Binaries/Win64
  wine64 ArkAscendedServer.exe ${MAP}?listen?SessionName="${SERVER_NAME}"?ServerPassword="${SRV_PWD}"${GAME_PARAMS}?ServerAdminPassword="${SRV_ADMIN_PWD}" ${GAME_PARAMS_EXTRA} &
  echo "Waiting for logs..."
  ATTEMPT=0
  sleep 2
  while [ ! -f "${SERVER_DIR}/ShooterGame/Saved/Logs/ShooterGame.log" ]; do
    ((ATTEMPT++))
    if [ $ATTEMPT -eq 10 ]; then
      echo "No log files found after 20 seconds, putting container into sleep mode!"
      sleep infinity
    else
      sleep 2
      echo "Waiting for logs..."
    fi
  done
  /opt/scripts/start-watchdog.sh &
  tail -n 9999 -f ${SERVER_DIR}/ShooterGame/Saved/Logs/ShooterGame.log
fi
