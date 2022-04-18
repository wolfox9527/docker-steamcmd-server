# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install Don't Starve Together and run it.

**ATTENTION:** After the first complete startup (you can see it in the log) copy your 'cluster_token.txt' in the 'token/Cluster_1' folder and restart the container.

**Update Notice:** Simply restart the container if a newer version of the game is available.

## Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '343050 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 343050 |
| CAVES | Delete 'true' if you don't want Caves on your Server. | true |
| GAME_PARAMS | Values to start the server | empty |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| VALIDATE | Validates the game data | true |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

## Run example
```
docker run --name DontStarveTogether -d \
	-p 10890:10890/udp -p 27016:27016/udp -p 8766:8766/udp \
	--env 'GAME_ID=343050' \
	--env 'CAVES=true' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /mnt/user/appdata/steamcmd:/serverdata/steamcmd \
	--volume /path/to/dontstarve:/serverdata/serverfiles \
	--volume /path/to/dontstarve/token:/serverdata/.klei/DoNotStarveTogether \
	ich777/steamcmd:dontstarve
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!


This Docker is forked from mattieserver, thank you for this wonderfull Docker.

### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/