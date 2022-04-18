# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install Avorion and run it.

**Update Notice:** Simply restart the container if a newer version of the game is available.

## Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '565060 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 565060 |
| GALAXY_NAME | Enter the Galaxy Name here (also the savepath will be the same as the Galaxy Name in the serverfiles folder, please use no spaces or special characters). | AvorionDocker |
| GAME_PARAMS | Values to start the server | empty |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| GAME_PORT | Port the server will be running on | 27015 |
| VALIDATE | Validates the game data | blank |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

## Run example
```
docker run --name Avorion -d \
	-p 27000:27000 -p 27000:27000/udp -p 27003:27003/udp -p 27020-27021:27020-27021/udp \
	--env 'GAME_ID=565060' \
	--env 'GALAXY_NAME=AvorionDocker' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/avorion:/serverdata/serverfiles \
	ich777/steamcmd:avorion
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/