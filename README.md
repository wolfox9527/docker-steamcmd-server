# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install Hurtworld and run it.

**Update Notice:** Simply restart the container if a newer version of the game is available.

## Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '405100 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 405100 |
| SRV_NAME | Enter your servername. | Hurtworld Docker |
| SRV_MAXPLAYERS | Enter the maximum allowed players | 50 |
| GAME_PARAMS | Values to start the server | ;autosaveenabled 1;addadmin 76561197963117432 |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| GAME_PORT | Port the server will be running on | 12871 |
| QUERY_PORT | Port the server will be running on | 12881 |
| VALIDATE | Validates the game data | true |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

## Run example
```
docker run --name Hurtworld -d \
	-p 12871:12871/udp -p 12881:12881/udp \
	--env 'GAME_ID=405100' \
	--env 'SRV_NAME=Hurtworld Docker' \
	--env 'SRV_MAXPLAYERS=50' \
	--env 'GAME_PORT=12871' \
	--env 'QUERY_PORT=12881' \
	--env 'GAME_PARAMS=;autosaveenabled 1;addadmin 76561197963117432' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/hurtworld:/serverdata/serverfiles \
	ich777/steamcmd:hurtworld
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/