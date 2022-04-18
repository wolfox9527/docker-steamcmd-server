# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install AssettoCorsa and run it.

**Install Note:** You must provide a valid Steam username and password with Steam Guard disabled (the user dosen't have to have the game in the library).&#xD;

**Update Notice:** Simply restart the container if a newer version of the game is available.

## Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID |  	The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '302550 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 302550 |
| INSTALL_STRACKER | Set to 'true' (without quotes) to install Stacker, otherwise leave blank (Please note that you can only Stacker or Assetto-Server-Manager, not both at the same time). | empty |
| INSTALL_ASSETTO_SERVER_MANAGER | Set to 'true' (without quotes) to install Assetto-Server-Manager, otherwise leave blank (Please note that you can only Stacker or Assetto-Server-Manager, not both at the same time). | empty |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| VALIDATE | Validates the game data | true |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

## Run example
```
docker run --name AssettoCorsa -d \
	-p 9600:9600 -p 9600:9600/udp -p 8081:8081 -p 50041:50041 -p 8772:8772 \
	--env 'GAME_ID=302550' \
	--env 'USERNAME=YOURSTEAMUSER' \
	--env 'PASSWRD=YOURSTEAMPASSWORD' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/assettocorsa:/serverdata/serverfiles \
	ich777/steamcmd:assettocorsa
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/