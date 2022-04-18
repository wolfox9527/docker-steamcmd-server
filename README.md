# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install Wurm Unlimited with or without the Server-ModLauncher and run it (You can also copy over the 'Creative' or 'Adventure' folder if you want to create a Server with the provided Servertool that comes with the game).

**Update Notice:** Simply restart the container if a newer version of the game is available.

## Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '402370 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 402370 |
| MOD_LAUNCHER | To enable the Server-ModLauncher set it to 'true' (without quotes) otherwise leave it blank. | blank |
| WU_SERVERNAME | Name of the Server | DockerServer |
| WU_PWD | Server Password to join | Docker |
| WU_ADMINPWD | Your Admin Password | adminDocker |
| WU_MAXPLAYERS | Define the maximum players on the server | 150 |
| WU_HOMESERVER | If set to 'true' (without quotes) Server is a homeserver and belongs to a single kingdom. | true |
| WU_HOMEKINGDOM | If you're using the Adventure base, use 1, 2, or 3. || If you're using Creative, use 4. || Kingdom numbers: 0 - No kingdom | 1 - Jen-Kellon | 2 - Mol-Rehan | 3 - Horde of the Summoned | 4 - Freedom | 4 |
| GAME_MODE | Choose between 'Adventure' and 'Creative' (without quotes) or copy your own map to the root of the serverfolder and define the name of the mapfolder here | Creative |
| WU_LOGINSERVER | If set to 'false' the server is intended to connect to another server who is the loginserver. | true |
| WU_EPICSERVERS | If set to true the server will follow the rules of the Epic servers in Wurm Online | false |
| GAME_PARAMS | Values to start the server | empty |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| GAME_PORT | Port the server will be running on | 3724 |
| WU_QUERYPORT | Query Port | 27020 |
| VALIDATE | Validates the game data | blank |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

## Run example
```
docker run --name WurmUnlimited -d \
	-p 8766:8766 -p 8766:8766/udp -p 3724:3724 -p 27020:27020/udp \
	--env 'GAME_ID=402370' \
	--env 'WU_SERVERNAME=DockerServer' \
	--env 'WU_PWD=Docker' \
	--env 'WU_ADMINPWD=adminDocker' \
	--env 'WU_MAXPLAYERS=150' \
	--env 'WU_HOMESERVER=true' \
	--env 'WU_HOMEKINGDOM=4' \
	--env 'GAME_MODE=Creative' \
	--env 'WU_LOGINSERVER=true' \
	--env 'WU_EPICSERVERS=false' \
	--env 'GAME_PORT=3724' \
	--env 'WU_QUERYPORT=27020' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/wurmunlimited:/serverdata/serverfiles \
	ich777/steamcmd:wurmunlimited
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/