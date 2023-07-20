# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install Icarus and run it.

Initial server configuration:  
**Servername:** Icarus Docker **Password:** Docker  **AdminPassword:** adminDocker  

**ATTENTION:** First startup can take very long since it downloads the gameserver files and it also installs the runtimes which can take quite some time! 

**First Start Notice:** On First startup the container installs the necessary runtimes and it might seem that the container hangs but please be patient since the installation can take very long on some systems (5 minutes+).

Update Notice: Simply restart the container if a newer version of the game is available.

## Example Env params for CS:Source
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '2089300 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 2089300 |
| GAME_PARAMS | Values to start the server | -SteamServerName="Icarus Docker" -Port=17777 -QueryPort=27015 |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| GAME_PORT | Port the server will be running on | 27015 |
| VALIDATE | Validates the game data | false |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

## Run example
```
docker run --name Icarus -d \
	-p 17777:17777/udp -p 27015:27015/udp \
	--env 'GAME_ID=2089300' \
	--env 'GAME_PARAMS=-SteamServerName="Icarus Docker" -Port=17777 -QueryPort=27015' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/icarus:/serverdata/serverfiles \
	ich777/steamcmd:icarus
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

#### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/