# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install Subsistence and run it.

**ATTENTION:** First startup can take very long since it downloads the gameserver files and also installs dotnet45!

**First Start Notice:** On First startup the container installs dotnet45 and it might seem that the container hangs but please be patient since the installation can take very long on some systems (5 minutes+).

Update Notice: Simply restart the container if a newer version of the game is available.

You can also run multiple servers with only one SteamCMD directory!

## Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '1362640 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 1362640 |
| GAME_PARAMS | Values to start the server, leave empty for none | empty |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| VALIDATE | Validates the game data | blank |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

## Run example
```
docker run --name Subsistence -d \
	-p 7777:7777/udp -p 27015:27015/udp \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/subsistence:/serverdata/serverfiles \
	ich777/steamcmd:subsistence
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/