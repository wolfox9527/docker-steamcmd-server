# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install Counter-Strike 2 and run it.

**ATTENTION:** You have to provide a valid Steam account with the game in it is Library and SteamGuard completely disabled so that the download is working!  
_It is recommended that you create dedicated Steam account for your dedicated servers with the games in it and SteamGuard completely disabled!_  
**DON'T DISABLE STEAM GUARD ON YOUR PRIMARY ACCOUNT!!!**

**Please see the different Tags/Branches which games are available.**

## Example Env
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '730 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 730 |
| USERNAME | Leave blank for anonymous login | <STEAMUSER> |
| PASSWRD | Leave blank for anonymous login | <STEAMPASSWORD> |
| GAME_PARAMS | Values to start the server | -dedicated -dev +map de_inferno +game_type 0 +game_mode 1 -usercon |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| GAME_PORT | Port the server will be running on | 27015 |
| VALIDATE | Validates the game data | blank |

## Run example
```
docker run --name CS2 -d \
	-p 27015:27015 -p 27015:27015/udp \
	--env 'GAME_ID=730' \
	--env 'USERNAME=<STEAMUSER>' \
	--env 'PASSWRD=<STEAMPASSWORD>' \
	--env 'GAME_PARAMS=-dedicated -dev +map de_inferno +game_type 0 +game_mode 1 -usercon' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/cs2:/serverdata/serverfiles \
	ich777/steamcmd:cs2
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

#### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/