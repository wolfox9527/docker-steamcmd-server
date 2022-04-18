# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install ATLAS and run it (this docker does also have a built in Redis server for quick server setup, you also can disable it in the variables below).

**ATTENTION:** First Startup can take very long since it downloads the gameserver files!

**Update Notice:** Simply restart the container if a newer version of the game is available.

## Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '1006030 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 1006030 |
| MAP_NAME | Standard Map Name | Ocean |
| GAME_PARAMS | Enter your start up commands for the server. | ?ServerX=0?ServerY=0?AltSaveDirectoryName=00?MaxPlayers=50?ReservedPlayerSlots=10?QueryPort=57550?Port=5750 |
| EXTRA_GAME_PARAMS | Port the server will be running on | -log -server -NoBattlEye |
| ENA_REDIS | If you've set up a external Redis server leave this blank, to enable the built in Redis server enter 'yes' (without quotes). | yes |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| VALIDATE | Validates the game data | true |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

## Run example
```
docker run --name ATLAS -d \
	-p 57550:57550/udp -p 5750-5751:5750-5751/udp -p 32330:32330/udp -p 27000:27000/udp \
	--env 'GAME_ID=232330' \
	--env 'MAP_NAME=Ocean' \
	--env 'EXTRA_GAME_PARAMS=-log -server -NoBattlEye' \
	--env 'GAME_PARAMS=?ServerX=0?ServerY=0?AltSaveDirectoryName=00?MaxPlayers=50?ReservedPlayerSlots=10?QueryPort=57550?Port=5750' \
	--env 'ENA_REDIS=yes' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/atlas:/serverdata/serverfiles \
	ich777/steamcmd:atlas
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/