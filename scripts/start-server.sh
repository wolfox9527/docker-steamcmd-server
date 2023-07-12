#!/bin/bash
export DISPLAY=:99
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
echo "---Checking if dotnet45 is installed---"
if [ ! -f ${SERVER_DIR}/dotnet45 ]; then
  echo "---dotnet45 not installed, please wait installing...---"
  find /tmp -name ".X99*" -exec rm -f {} \; > /dev/null 2>&1
  /opt/scripts/start-Xvfb.sh 2>/dev/null &
  echo "---...this can take some time...---"
  sleep 5
  /usr/bin/winetricks -q dotnet45 2>/dev/null
  wine64 ${SERVER_DIR}/Binaries/Win64/UDK.exe server coldmap1?steamsockets >/dev/null 2&>1 &
  sleep 10
  kill $(pidof UDK.exe)
  kill $(pidof Xvfb)
  sed -i "/^Password=/c\Password=Docker" ${SERVER_DIR}/UDKGame/Config/UDKDedServerSettings.ini
  sed -i "/^AdminPassword=/c\AdminPassword=adminDocker" ${SERVER_DIR}/UDKGame/Config/UDKDedServerSettings.ini
  sed -i "/^ServerName=/c\ServerName=Subsistence Docker" ${SERVER_DIR}/UDKGame/Config/UDKDedServerSettings.ini
  sed -i "/^ServerDescription=/c\ServerDescription=Subsistence running in Docker" ${SERVER_DIR}/UDKGame/Config/UDKDedServerSettings.ini
  sed -i "/^HostedByName=/c\HostedByName=Unraid" ${SERVER_DIR}/UDKGame/Config/UDKDedServerSettings.ini
  touch ${SERVER_DIR}/dotnet45
  echo "---Installation from dotnet45 finished!---"
else
  echo "---dotnet45 found! Continuing...---"
fi

echo "---Checking for old display lock files---"
find /tmp -name ".X99*" -exec rm -f {} \; > /dev/null 2>&1
chmod -R ${DATA_PERM} ${DATA_DIR}
echo "---Server ready---"

echo "---Starting Xvfb server---"
screen -S Xvfb -L -Logfile ${SERVER_DIR}/XvfbLog.0 -d -m /opt/scripts/start-Xvfb.sh
sleep 5

echo "---Start Server---"
if [ ! -f ${SERVER_DIR}/Binaries/Win64/UDK.exe ]; then
  echo "---Something went wrong, can't find the executable, putting container into sleep mode!---"
  sleep infinity
else
  cd ${SERVER_DIR}/Binaries/Win64
  screen -S UDK -d -m wine64 ${SERVER_DIR}/Binaries/Win64/UDK.exe server coldmap1?steamsockets -log ${GAME_PARAMS}
  sleep 2
  /opt/scripts/start-watchdog.sh &
  tail -f ${SERVER_DIR}/UDKGame/Logs/Launch.log
fi