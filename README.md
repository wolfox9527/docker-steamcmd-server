# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install American Truck Simulator and run it.

**Server Credentials:** The default name from the server is: **Docker Server** and the password is: **Docker**

**ATTENTION:** First Startup can take very long since it downloads the gameserver files and the world template!

**Server Configuration:** For more information see the file 'server_readme.txt' in the main directory from the dedicated server.

**Save Path:** The configuration files and save data is located in: '.../.local/share/American Truck Simulator '.

**Update Notice:** Simply restart the container if a newer version of the game is available.

You can also run multiple servers with only one SteamCMD directory!

## Example Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '2239530 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 2239530 |
| GAME_PARAMS | Enter your game parameters (only change the worldId if you know what you are doing!) | empty |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| VALIDATE | Validates the game data | false |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

## Run example
```
docker run --name AmericanTruckSimulator -d \
	-p 27015-27016:27015-27016/udp \
	--env 'GAME_ID=2239530' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/americantrucksimulator:/serverdata/serverfiles \
	ich777/steamcmd:ats
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

#### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/