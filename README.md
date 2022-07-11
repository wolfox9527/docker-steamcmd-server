# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install DayZ and run it.

**Keep in mind that you have to connect with the experimental branch Client to this Docker container!**

Initial Server Name: Docker DayZ
Initial connection Password: Docker
Initial admin Password: adminDocker

**GAME CONFIG & SAVE FOLDER**: Your saves are located in .../appdata/dayz/saves/ and your config file is located at .../appdata/dayz/saves/serverDZ.cfg
(please note that changes to the serverDZ.cfg in the main directory take no effect, you have to edit the file .../saves/serverDZ.cfg)

## Example Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '1042420 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 1042420 |
| GAME_PORT | Port the server will be running on | 2302 |
| GAME_PARAMS | Leave empty if not needed | |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| GAME_PORT | Port the server will be running on | 27015 |
| VALIDATE | Validates the game data | true |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

## Run example
```
docker run --name DayZ -d \
	-p 2302:2302/udp -p 27016:27016/udp \
	--env 'GAME_ID=1042420' \
	--env 'GAME_PORT=2302' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/dayz:/serverdata/serverfiles \
	ich777/steamcmd:dayz
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

#### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/