# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install TerraTech Worlds and run it.

**ATTENTION:** First Startup can take very long since it downloads the gameserver files!

**Update Notice:** Simply restart the container if a newer version of the game is available.

## Example Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '2533070 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 2533070 |
| GAME_PARAMS | Values to start the server | empty |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| VALIDATE | Validates the game data | true |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

## Run example
```
docker run --name TerraTech-Worlds -d \
	-p 7777:7777/udp \
	--env 'GAME_ID=2533070' \
	--env 'UID=99' \
	--env 'GID=100' \
	--env 'UMASK=0000' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/terratech-worlds:/serverdata/serverfiles \
	ich777/steamcmd:terratechworlds
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

#### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/