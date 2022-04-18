# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install LambdaWars and run it.

**STEAM CREDENTIALS:** For this container you have to provide valid Steam credentials where SteamGuard is disabled and this user need to have the game in it's library (since this game is free you can simply add it to this account).
It is recommended to create a dedicated Steam account for dedicated servers so that account theft of your personal account is impossible.

## Example Env params for CS:Source
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '319060 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 319060 |
| GAME_NAME | SRCDS gamename | lambdawars |
| GAME_PARAMS | Values to start the server | +maxplayers 8 +map gamelobby |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| GAME_PORT | Port the server will be running on | 27015 |
| VALIDATE | Validates the game data | blank |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

## Run example
```
docker run --name LambdaWars -d \
	-p 27015:27015/udp -p 27005:27005/udp -p 27020:27020/udp -p 26901:26901/udp -p 27015:27015 \
	--env 'GAME_ID=319060' \
	--env 'GAME_NAME=lambdawars' \
	--env 'GAME_PORT=27015' \
	--env 'USERNAME=YOURSTEAMUSER' \
	--env 'PASSWRD=YOURSTEAMPASSWORD' \
	--env 'GAME_PARAMS=+maxplayers 8 +map gamelobby' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/lambdawars:/serverdata/serverfiles \
	ich777/steamcmd:lambdawars
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

#### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/