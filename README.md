# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install Colony Survival and run it.

**CONSOLE:** To connect to the console open up a terminal and type in: 'docker exec -u steam -ti NAMEOFYOURCONTAINER screen -xS ColonySurvival' (without quotes),

**Update Notice:** Simply restart the container if a newer version of the game is available.

## Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '748090 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 748090 |
| SRV_NAME | Enter you preferred servername. | Colony Survival Docker |
| SRV_WORLDNAME | Enter your preferred world name. | ColonySurvival |
| GAME_PARAMS | Enter your start up commands for the server (If you want a password on your server please add for example: '+server.password Docker' without quotes. In this case 'Docker' is the password. You can also enter multiple commands like: '+server.maxplayers +server.password Docker' without quotes) | +server.gameport 27016 |
| SRV_NETTYPE | Choose between: 'LAN' -allows connecting from localhost through the ingame button | 'SteamLAN' -steam networking, does not port forward or check authentication | 'SteamOnline' -steam networking, port forwards and checks authentication | SteamOnline |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| VALIDATE | Validates the game data | blank |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

***ATTENTION: You have to disable Steam Guard for games that require authentication, Steam recommends to create a seperate account for dedicated servers***

>**NOTE** GAME_ID values can be found [here](https://developer.valvesoftware.com/wiki/Dedicated_Servers_List)

> And for GAME_NAME there is no list, so a quick search should give you the result

## Run example
```
docker run --name ColonySurvival -d \
	-p 27016:27016/udp \
	--env 'GAME_ID=748090' \
	--env 'SRV_NAME=Colony Survival Docker' \
	--env 'SRV_WORLDNAME=Colony Survival' \
	--env 'SRV_NETTYPE=SteamOnline' \
	--env 'GAME_PARAMS=+server.gameport 27016' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/colonysurvival:/serverdata/serverfiles \
	ich777/steamcmd:colonysurvival
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/