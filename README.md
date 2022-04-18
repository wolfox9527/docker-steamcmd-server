# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install SCP:Secret Laboratory with MultiAdmin and ServerMod and run it.

**Update Notice:** Simply restart the container if a newer version of the game is available.

**CONSOLE:** To connect to the console open up a terminal and type in: 'docker exec -u steam -ti NAMEOFYOURCONTAINER screen -xS SCP' (without quotes), to disconnect from the console simply close the window.

## Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '996560 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 996560 |
| GAME_PARAMS | Values to start the server | empty |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| VALIDATE | Validates the game data | blank |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

## Run example
```
docker run --name SCP-SecretLaboratory -d \
	-p 7777:7777 -p 7777:7777/udp \
	--env 'GAME_ID=996560' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/scp-secretlaboratory:/serverdata/serverfiles \
	ich777/steamcmd:scp-secretlaboratory
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/