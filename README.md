# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install Stormworks and run it.

Initial server configuration:  
**Servername:** Stormworks Docker **Password:** Docker   

**Configuration/Save Location:** You'll find your server configuration and saved games in: ../WINE64/drive_c/users/steam/AppData/Roaming/Stormworks/

**ATTENTION:** First startup can take very long since it downloads the gameserver files and it also installs the runtimes which can take quite some time! 

Update Notice: Simply restart the container if a newer version of the game is available.

## Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_PARAMS | Values to start the server if needed. | empty |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '1247090 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 1247090 |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| VALIDATE | Validates the game data | false |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |


## Run example
```
docker run --name Stormworks -d \
	-p 25564-25565/udp \
	--env 'GAME_ID=1247090' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/stormworks:/serverdata/serverfiles \
	ich777/steamcmd:stormworks
```


This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!


This Docker is forked from mattieserver, thank you for this wonderfull Docker.

### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/
