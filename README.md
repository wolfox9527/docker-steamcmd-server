# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install Insurgency Sandstorm and run it.

**PASSWORD:** The initial password is 'Docker', if you want to change or delete it look below at the section GAME_PARAMS.

**Update Notice:** Simply restart the container if a newer version of the game is available.

## Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '581330 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 581330 |
| SERVER_NAME | Enter your servername here. | DockerServer |
| GAME_PARAMS | Values to start the server | Oilfield?Scenario=Scenario_Refinery_Push_Security?MaxPlayers=28?Password=Docker |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| GAME_PORT | Port the server will be running on | 27102 |
| QUERY_PORT | Port the server will be running on | 27015 |
| VALIDATE | Validates the game data | blank |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

## Run example
```
docker run --name InsurgencySandstorm -d \
	-p 27102:27102/udp -p 27131:27131/udp \
	--env 'GAME_ID=581330' \
	--env 'SERVER_NAME=DockerServer' \
	--env 'GAME_PORT=27102' \
	--env 'QUERY_PORT=27131' \
	--env 'GAME_PARAMS=Oilfield?Scenario=Scenario_Refinery_Push_Security?MaxPlayers=28?Password=Docker' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/insurgencysandstorm:/serverdata/serverfiles \
	ich777/steamcmd:insurgencysandstorm
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/