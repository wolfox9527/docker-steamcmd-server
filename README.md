# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install V Rising and run it.

**Save Files:** The save files are located in: .../vrising/save-data/Saves
**Config Files:** The config files are located in: .../vrising/save-data/Settings

**ATTENTION:** First Startup can take very long since it downloads the gameserver files!

**Update Notice:** Simply restart the container if a newer version of the game is available.

## Example Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '1829350 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 1829350 |
| SERVER_NAME | Enter your preferred server name. | V Rising Docker |
| WORLD_NAME | Enter your prefered world name. | world1 |
| GAME_PARAMS | Enter additional game startup parameters if needed, otherwise leave empty. | empty |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| GAME_PORT | Port the server will be running on | 27015 |
| VALIDATE | Validates the game data | true |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

## Run example
```
docker run --name V-Rising -d \
	-p 9876-9877:9876-9877/udp \
	--env 'GAME_ID=1829350' \
	--env 'SERVER_NAME=V Rising Docker' \
	--env 'WORLD_NAME=world1' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/vrising:/serverdata/serverfiles \
	ich777/steamcmd:vrising
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

#### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/