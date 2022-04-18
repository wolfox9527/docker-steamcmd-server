# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install Citadel - Forged with Fire and run it.

**Update Notice:** Simply restart the container if a newer version of the game is available.

## Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '489650  -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 489650  |
| GAME_PARAMS | Enter your start up commands for the server (for example the server admin: --admin [YOURsteamID64] e.g: '--admin 123456789123456789' without quotes). | empty |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| GAME_PORT | Port the server will be running on | 27015 |
| VALIDATE | Validates the game data | blank |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

## Run example
```
docker run --name Citadel-ForgedWithFire -d \
	-p 7777:7777/udp -p 27015:27015/udp \
	--env 'GAME_ID=489650 ' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/citadelfwf:/serverdata/serverfiles \
	ich777/steamcmd:citadelfwf
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/