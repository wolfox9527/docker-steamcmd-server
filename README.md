# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install The Front and run it.

Initial server configuration:  
**Servername:** The Front Docker
**Password:** Docker  

Your configuration file is located at: .../TheFrontManager/ServerConfig_.ini

**ATTENTION:** First startup can take very long since it downloads the gameserver files and it also installs the runtimes which can take quite some time! 

Update Notice: Simply restart the container if a newer version of the game is available.

## Example Env params for CS:Source
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '2334200 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 2334200 |
| GAME_PARAMS | Change if needed (put '?' in between the options if using multiple) | MaxPlayers=60 |
| GAME_PARAMS_EXTRA | Change if needed (specify your extra game parameters here like: Servername, Password, Ports,...) | -QueueThreshold=60 -port=15636 -BeaconPort=15637 -QueryPort=15638 -UseACE=true |
| PUBLIC_IP | Set your public IP here (if set to 'auto' the container will try to obtain the public IP automatically) | auto |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| VALIDATE | Validates the game data | blank |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

## Run example
```
docker run --name TheFront -d \
	-p 15636-15638:15636-15638/udp \
	--env 'GAME_ID=232330' \
	--env 'GAME_PARAMS=MaxPlayers=60' \
	--env 'GAME_PARAMS_EXTRA=-QueueThreshold=60 -port=15636 -BeaconPort=15637 -QueryPort=15638 -UseACE=true' \
	--env 'PUBLIC_IP=auto' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/thefront:/serverdata/serverfiles \
	ich777/steamcmd:thefront
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

#### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/