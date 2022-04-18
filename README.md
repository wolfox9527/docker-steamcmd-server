# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install Counter-Strike 1.6 and run it.

**Update Notice:** Simply restart the container if a newer version of the game is available.

## Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '90 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 90 |
| GAME_NAME | SRCDS gamename | cstrike |
| GAME_PARAMS | Values to start the server | +maxplayers 32 +map de_dust |
| GAME_MOD | Only required for Goldsource Games | blank |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| GAME_PORT | Port the server will be running on | 27015 |
| VALIDATE | Validates the game data | blank |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

## Run example
```
docker run --name CStrike1.6 -d \
	-p 27015:27015 -p 27015:27015/udp \
	--env 'GAME_ID=90' \
	--env 'GAME_NAME=cstrike' \
	--env 'GAME_PORT=27015' \
	--env 'GAME_PARAMS=+maxplayers 32 +map de_dust' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/cstrike1.6:/serverdata/serverfiles \
	ich777/steamcmd:cstrike1.6
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/