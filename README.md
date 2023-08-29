# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install Life is Feudal: Your Own and run it.

Initial server configuration:  
**Servername:** LiF Docker **Password:** Docker **Admin Password:** adminDocker  

**ATTENTION:** First startup can take very long since it downloads the gameserver files and it also installs the runtimes which can take quite some time! 

Update Notice: Simply restart the container if a newer version of the game is available.

## Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_PARAMS | Values to start the server if needed. | empty |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '320850 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 320850 |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| VALIDATE | Validates the game data | false |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |


## Run example
```
docker run --name LifeIsFeudal-YourOwn -d \
	-p 28000-28003 -p 28000-28003/udp \
	--env 'GAME_ID=320850' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/lifeisfeudal-yo:/serverdata/serverfiles \
	ich777/steamcmd:lifyo
```


This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!


This Docker is forked from mattieserver, thank you for this wonderfull Docker.

### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/
