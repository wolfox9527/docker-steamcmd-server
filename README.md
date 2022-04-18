# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install Starbound (Valid Steam useraccount with the game purchased and Steam Guard disabled required) and run it.

**ATTENTION:** For this Docker you have to specify a valid Steam account with Steam Guard disabled and the game in the library otherwise the gamefiles won't download!

**Update Notice:** Simply restart the container if a newer version of the game is available.

## Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '533830 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 533830 |
| GAME_NAME | SRCDS gamename | cstrike |
| GAME_PARAMS | Values to start the server | empty |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| VALIDATE | Validates the game data | blank |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

## Run example
```
docker run --name Starbound -d \
	-p 21025:21025 -p 21025:21025/udp -p 21026:21026 \
	--env 'GAME_ID=533830' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/starbound:/serverdata/serverfiles \
	ich777/steamcmd:starbound
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/