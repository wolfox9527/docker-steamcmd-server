# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install Soulmask and run it.

Defaults: Servername: 'Soulmask Docker' Password: 'Docker' Admin Password: 'adminDocker'
(You can change that in the GAME_PARAMS variable)

ATTENTION: First Startup can take very long since it downloads the gameserver files!

Update Notice: Simply restart the container if a newer version of the game is available.

You can also run multiple servers with only one SteamCMD directory!

## Example Env
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '3017300 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 3017300 |
| MAP | Map name | Level01_Main |
| GAME_PARAMS | Values to start the server | -SteamServerName='Soulmask Docker' -MaxPlayers=50 -PSW='Docker' -adminpsw='adminDocker' -pve -Port=8777 -QueryPort=27015 -EchoPort=18888 |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| GAME_PORT | Port the server will be running on | 27015 |
| VALIDATE | Validates the game data | blank |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

## Run example for CS:Source
```
docker run --name Soulmask -d \
	-p 8777:8777/udp -p 27015:27015/udp \
	--env 'GAME_ID=3017300' \
	--env 'MAP=Level01_Main' \
	--env 'GAME_PARAMS=-SteamServerName='Soulmask Docker' -MaxPlayers=50 -PSW='Docker' -adminpsw='adminDocker' -pve -Port=8777 -QueryPort=27015 -EchoPort=18888' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/soulmask:/serverdata/serverfiles \
	ich777/steamcmd:soulmask
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

#### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/