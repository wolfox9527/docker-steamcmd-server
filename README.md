# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install ECO and run it.

**PASSWORD:** The initial password is 'Docker'.

**Update Notice:** Simply restart the container if a newer version of the game is available.

## Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '739590 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 739590 |
| GAME_PARAMS | Values to start the server | empty |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| VALIDATE | Validates the game data | blank |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

## Run example
```
docker run --name ECO -d \
	-p 3001:3001 -p 3000:3000/udp \
	--env 'GAME_ID=739590' \
	--env 'GAME_PARAMS=-secure +maxplayers 32 +map de_dust2' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/eco:/serverdata/serverfiles \
	ich777/steamcmd:eco
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/