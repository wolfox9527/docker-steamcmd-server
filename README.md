# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install Barotrauma and run it.

**Update Notice:** Simply restart the container if a newer version of the game is available.

**CONSOLE:** To connect to the console from Unraid itself and type in: 'docker exec -u steam -ti NAMEOFYOURCONTAINER screen -xS Barotrauma' (without quotes), to disconnect from the console simply close the window.

## Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '1026340 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 1026340 |
| GAME_PARAMS | Values to start the server | empty |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| GAME_PORT | Port the server will be running on | 27015 |
| VALIDATE | Validates the game data | blank |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

## Run example
```
docker run --name Barotrauma -d \
	-p 27015-27016:27015-27016/udp \
	--env 'GAME_ID=1026340' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/barotrauma:/serverdata/serverfiles \
	ich777/steamcmd:barotrauma
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/