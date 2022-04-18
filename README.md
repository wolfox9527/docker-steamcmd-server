# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install Pirates, Vikings & Knights 2 and run it.

**Update Notice:** Simply restart the container if a newer version of the game is available.

## Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '17575 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 17575 |
| GAME_NAME | SRCDS gamename | pvkii |
| GAME_PARAMS | Values to start the server | -maxplayers 18 +map bt_island |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| GAME_PORT | Port the server will be running on | 27015 |
| VALIDATE | Validates the game data | blank |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

## Run example
```
docker run --name PVK-II -d \
	-p 27015:27015 -p 27015:27015/udp \
	--env 'GAME_ID=17575' \
	--env 'GAME_NAME=pvkii' \
	--env 'GAME_PORT=27015' \
	--env 'GAME_PARAMS=-maxplayers 18 +map bt_island' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/pvkii:/serverdata/serverfiles \
	ich777/steamcmd:pvkii
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/