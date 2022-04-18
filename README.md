# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install Longvinter and run it.

**Initial Server Name:** Longvinter Docker
**Initial Password:** Docker

Update Notice: Simply restart the container if a newer version of the game is available.

## Example Env params for CS:Source
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_PARAMS | Values to start the server | empty |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| GAME_PORT | Port the server will be running on | 27016 |

## Run example
```
docker run --name Longvinter -d \
	-p 27016:27016/udp \
	--env 'GAME_PORT=27016' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/longvinter:/serverdata/serverfiles \
	ich777/steamcmd:longvinter
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

#### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/