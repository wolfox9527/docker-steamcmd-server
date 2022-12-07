# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install Creativerse and run it.

**ATTENTION:** First Startup can take very long since it downloads the gameserver files and the world template!

**Update Notice:** Simply restart the container if a newer version of the game is available.

You can also run multiple servers with only one SteamCMD directory!

**Note:** As time of creating the container the WebGUI isn't working but you should be able to do all things from in game. The developers from the game will implement this later on.

## Example Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '1098260 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 1098260 |
| GAME_PARAMS | Enter your game parameters (only change the worldId if you know what you are doing!) | -worldId=unraid_world |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| GAME_PORT | Port the server will be running on | 27015 |
| VALIDATE | Validates the game data | false |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

## Run example
```
docker run --name Creativerse -d \
	-p 26900:26900/udp -p 26901:26901/udp -p 26902:26902/udp \
	--env 'GAME_ID=1098260' \
	--env 'GAME_PARAMS=-worldId=unraid_world' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/creativerse:/serverdata/serverfiles \
	ich777/steamcmd:creativerse
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

#### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/