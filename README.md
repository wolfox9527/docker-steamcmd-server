# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install Sons Of The Forest and run it.

**SERVERNAME:** 'Sons Of The Forest Docker Server'
**SERVERPASSWORD:** 'Docker'
(you can change this in your SERVERFOLDER/userdata/dedicatedserver.cfg)

**ATTENTION:** First Startup can take very long since it downloads the gameserver files!

**WARNING:** You have to open the ports in your firewall as listed in this template, if not the server will not properly start.
If you want LAN play only you have to edit the dedicatedserver.cfg file and set the "LanOnly" flag to: "true" (without double quotes).

Update Notice: Simply restart the container if a newer version of the game is available.

You can also run multiple servers with only one SteamCMD directory!

## Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '2465200 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 2465200 |
| GAME_PARAMS | Values to start the server, leave empty for none | empty |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| GAME_PORT | Port the server will be running on | 27015 |
| VALIDATE | Validates the game data | blank |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

## Run example
```
docker run --name SonsOfTheForest -d \
	-p 8766:8766/udp -p 27016:27016/udp -p 9700:9700/udp \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/sonsoftheforest:/serverdata/serverfiles \
	ich777/steamcmd:sonsoftheforest
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/