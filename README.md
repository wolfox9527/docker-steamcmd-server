# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install PIXARK and run it (a normal server startup of PIXARK can take a long time!).

**Update Notice:** Simply restart the container if a newer version of the game is available.

## Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '824360 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 824360 |
| MAP | Map name | CubeWorld_Light |
| SERVER_NAME | Leave empty if you want to use the settings from GameUserSettings.ini (this field accepts no spaces) | PIXARKDocker |
| SRV_PWD | Leave empty if you want to use the settings from GameUserSettings.ini (this field accepts no spaces) | Docker |
| SRV_ADMIN_PWD | Leave empty if you want to use the settings from GameUserSettings.ini (this field accepts no spaces) | adminDocker |
| GAME_PARAMS | Enter your game parameters seperated with ? and start with a ? (don't put spaces in between eg: ?MaxPlayers=40?FastDecayUnsnappedCoreStructures=true) | ?MaxPlayers=10 |
| GAME_PARAMS_EXTRA | Type in your Extra Game Parameters seperated with a space and - (eg: -DisableDeathSpectator -UseBattlEye) | -QueryPort=27016 -Port=27015 -CubePort=27018 -NoBattlEye -nosteamclient -game -server -log |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| VALIDATE | Validates the game data | blank |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

## Run example
```
docker run --name PIXARK -d \
	-p 27015:27015/udp -p 27016:27016/udp -p 27018:27018/udp \
	--env 'GAME_ID=824360' \
	--env 'MAP=CubeWorld_Light' \
	--env 'SERVER_NAME=PIXARKDocker' \
	--env 'SRV_PWD=Docker' \
	--env 'SRV_ADMIN_PWD=adminDocker' \
	--env 'GAME_PARAMS=?MaxPlayers=10' \
	--env 'GAME_PARAMS_EXTRA=-QueryPort=27016 -Port=27015 -CubePort=27018 -NoBattlEye -nosteamclient -game -server -log' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/pixark:/serverdata/serverfiles \
	ich777/steamcmd:pixark
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/