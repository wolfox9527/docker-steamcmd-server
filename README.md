# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install Abiotic Factor and run it.

ATTENTION: First Startup can take very long since it downloads the gameserver files!

Update Notice: Simply restart the container if a newer version of the game is available.

You can also run multiple servers with only one SteamCMD directory!

## Example Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '2857200 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 2857200 |
| SERVER_NAME | Your server name goes here | Abiotic Factor Docker |
| SERVER_PWD | Your server password goes here | Docker |
| GAME_PARAMS | Enter your game parameters | -log |
| GAME_PORT | Enter your preferred game port | 7777 |
| QUERY_PORT | Enter your preferred query port | 27015 |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| VALIDATE | Validates the game data | blank |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

## Run example
```
docker run --name AbioticFactor -d \
	-p 7777:7777/udp -p 27015:27015/udp\
	--env 'GAME_ID=2857200' \
	--env 'SERVER_NAME=Abiotic Factor Docker' \
	--env 'SERVER_PWD=Docker' \
	--env 'GAME_PARAMS=-log' \
	--env 'GAME_PORT=7777' \
	--env 'QUERY_PORT=27015' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/abioticfactor:/serverdata/serverfiles \
	ich777/steamcmd:abioticfactor
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

#### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/