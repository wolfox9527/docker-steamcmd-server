# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install CoreKeeper and run it.

**GameID:** Your GameID will be displayed in the log after the server successfully started.

**Port Forwarding:** You don't have to forward any ports for this game because it uses the Steam Network and the GameID to establish the connection.

Update Notice: Simply restart the container if a newer version of the game is available.

## Example Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '1963720 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 1963720 |
| WORLD_NAME | Enter your prefered world name here. | Core Keeper Docker |
| WORLD_INDEX | Only change when you know what you are doing! | cstrike |
| GAME_PARAMS | Values to start the server | -secure +maxplayers 32 +map de_dust2 |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| VALIDATE | Validates the game data | true |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

## Run example
```
docker run --name CoreKeeper -d \
	--env 'GAME_ID=1963720' \
	--env 'WORLD_NAME=Core Keeper Docker' \
	--env 'WORLD_INDEX=0' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/corekeeper:/serverdata/serverfiles \
	ich777/steamcmd:corekeeper
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

#### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/