# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install Chivalry: Medieval Warfare and run it.

**Update Notice:** Simply restart the container if a newer version of the game is available.

**Server Config:** You find the server config in: '../appdata/UDKGame/Config/' (eg: the servername is located in: 'PCServer-UDKGame.ini')

## Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '220070 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 220070 |
| MAP | Map name (eg: 'aocffa-arena3_p', 'aocffa-hillside_p', 'aocffa-battlegrounds_v3_p') | aocffa-moor_p |
| ADMIN_PWD | Server Admin Password (can't be empty) | adminDocker |
| GAME_PARAMS | Values to start the server | ?port=7000?queryport=7010 |
| GAME_PARAMS_EXTRA | Type in your Extra Game Parameters seperated with a space and - (eg: -seekfreeloadingserver) | -seekfreeloadingserver |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| VALIDATE | Validates the game data | blank |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

## Run example
```
docker run --name Chivalry-MedievalWarfare -d \
	-p 7000:7000/udp -p 7010:7010/udp -p 27015:27015/udp \
	--env 'GAME_ID=220070' \
	--env 'MAP=aocffa-moor_p' \
	--env 'ADMIN_PWD=adminDocker' \
	--env 'GAME_PARAMS=?port=7000?queryport=7010' \
	--env 'GAME_PARAMS_EXTRA=-seekfreeloadingserver' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/chivalrymw:/serverdata/serverfiles \
	ich777/steamcmd:chivalrymw
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/