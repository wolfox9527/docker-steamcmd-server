# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install Pavlov VR and run it.

**Update Notice:** Simply restart the container if a newer version of the game is available.

**ATTENTION:** I would strongly recommend that you mount a path to the /tmp directory inside the container like in the run example because maps will be downloaded to the /tmp directory and will be wiped on a container update.

## Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '622970 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 622970 |
| GAME_PARAMS | Values to start the server | empty |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| VALIDATE | Validates the game data | blank |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

## Run example
```
docker run --name PavlovVR -d \
	-p 27015:27015 -p 27015:27015/udp \
	--env 'GAME_ID=622970' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/pavlovvr:/serverdata/serverfiles \
	--volume /path/to/pavlovvr/temp-maps:/tmp \
	ich777/steamcmd:pavlovvr
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/