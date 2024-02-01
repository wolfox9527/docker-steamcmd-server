# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install Astroneer and run it.

**ATTENTION:** You have to add this entry to the Engine.ini from the clients which are going to connecting to this dedicated server:
```
[SystemSettings]
net.AllowEncryption=False
```
You'll find the file on your local Windows machine at: `%localappdata%\Astro\Saved\Config\WindowsNoEditor`

**WARNING:** If a client tries to connect to the Dedicated Server which don't has this entry in the Engine.ini the server will be left in a semi bricked state and you have to restart the Docker container.

**Servername:** 'AstroneerDocker' Password: 'Docker' ConsolePassword: 'adminDocker'

**Serveradmin:** If you want to become a server admin then stop the container and edit the file ../Astro/Saved/Config/WindowsServer/AstroServerSettings.ini and add your Steam name after `OwnerName=` eg: `OwnerName=YourSteamName`, after that start the container and connect to the Dedicated Server.

**Update Notice:** Simply restart the container if a newer version of the game is available.

## Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_PARAMS | Values to start the server if needed. | empty |
| UPDATE_PUBLIC_IP | If set to 'true' the container will check on each container start if the Public IP is still valid. | false |
| BACKUP | Set this value to 'true' to enable the automated backup function from the container, you find the Backups in '.../astroneer/Backups/'. Set to 'false' to disable the backup function. | true |
| BACKUP_INTERVAL | The backup interval in minutes (ATTENTION: The first backup will be triggered after the set interval in this variable after the start/restart of the container) | 360 |
| BACKUP_TO_KEEP | Number of backups to keep (by default set to 8 to keep the last backups of the last 48 hours) | 8 |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| VALIDATE | Validates the game data | false |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |


## Run example
```
docker run --name Astroneer -d \
	-p 8777:8777/udp \
	--env 'GAME_ID=728470' \
	--env 'UPDATE_PUBLIC_IP=false' \
	--env 'BACKUP=true' \
	--env 'BACKUP_INTERVAL=360' \
	--env 'BACKUP_TO_KEEP=8' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/astroneer:/serverdata/serverfiles \
	ich777/steamcmd:astroneer
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/
