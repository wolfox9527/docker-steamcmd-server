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

if [[ ! $LOGIN_TIMEOUT =~ ^[0-9]+$ ]]; then
  echo "LOGIN_TIMEOUT must be a integer, putting container into sleep mode!"
  sleep infinity
fi

if [ "$LOGIN_TIMEOUT" -gt 0 ]; then
  echo "---Update Server---"
  if [ "$LOGIN_TIMEOUT" -lt 5 ]; then
    echo "LOGIN_TIMEOUT must be greater than 5 seconds, changing to 30!"
    LOGIN_TIMEOUT=30
  fi

  if [ ! -f ~/.screenrc ]; then
    echo "defscrollback 30000
bindkey \"^C\" echo 'Blocked. Close this window to exit the terminal.'" > ~/.screenrc
  fi

  screen -wipe 2&>/dev/null

  if [ ! -d ${DATA_DIR}/Steam/logs ]; then
    mkdir -p ${DATA_DIR}/Steam/logs
  elif [ -f ${DATA_DIR}/Steam/logs/steamcmd.log ]; then
    rm -f ${DATA_DIR}/Steam/logs/steamcmd.log
  fi

  screen -S steamcmd -L -Logfile ${DATA_DIR}/Steam/logs/steamcmd.log -d -m \
    ${STEAMCMD_DIR}/steamcmd.sh \
    +force_install_dir ${SERVER_DIR} \
    +login ${USERNAME} ${PASSWRD} \
    +app_update ${GAME_ID} \
    +quit

  sleep 1

  /opt/scripts/start-gotty.sh >/dev/null 2>&1 &

  echo "+----------------------------------------------------------------------"
  echo "| Please connect to the built in SteamCMD web console (not the Docker"
  echo "| console) and enter your 2FA token if you have SteamGuard enabled."
  echo "|"
  echo "| You can close the SteamCMD web console after entering the 2FA token."
  echo "+----------------------------------------------------------------------"
  echo
  echo "Waiting $LOGIN_TIMEOUT seconds for login..."
  echo

  ELAPSED_TIME=0
  while [ $ELAPSED_TIME -lt $LOGIN_TIMEOUT ]; do
    if grep -q "Waiting for user info...OK" ${DATA_DIR}/Steam/logs/steamcmd.log; then
      echo "Login successfull, continuing, please wait..."
      sed -i 's/^Two-factor code:.*/Two-factor code:\*HIDDEN\*/' ${DATA_DIR}/Steam/logs/steamcmd.log
      /opt/scripts/start-tail.sh
      rm -f ${DATA_DIR}/Steam/logs/steamcmd.log
      screen -wipe 2&>/dev/null
      LOGINOK="true"
      break
    else
      sleep 2
      ((ELAPSED_TIME += 2))
    fi
  done

  if [ "$LOGINOK" != "true" ]; then
    echo "Login Failed after $LOGIN_TIMEOUT seconds, continuing..."
    kill -SIGKILL $(pgrep screen) >/dev/null 2>&1
    kill -SIGKILL $(pidof gotty) >/dev/null 2>&1
    sed -i 's/^Two-factor code:.*/Two-factor code:\*HIDDEN\*/' ${DATA_DIR}/Steam/logs/steamcmd.log
    cat ${DATA_DIR}/Steam/logs/steamcmd.log
    rm -f ${DATA_DIR}/Steam/logs/steamcmd.log >/dev/null 2>&1
    screen -wipe 2&>/dev/null
  fi
else
  echo "LOGIN_TIMEOUT set to 0, Update Server skipped!"
fi

export USERNAME="secret"
export PASSWRD="secret"

echo "---Prepare Server---"
chmod -R ${DATA_PERM} ${DATA_DIR}
echo "---Server ready---"

echo "---Start Server---"

echo
echo "---Putting container into sleep mode zZzZzZzZz---"
sleep infinity