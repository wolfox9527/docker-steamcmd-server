# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install FrozenFlame and run it.

**ATTENTION:** First Startup can take very long since it downloads the gameserver files!

**Update Notice:** Simply restart the container if a newer version of the game is available.

**Configuration:** You can find a example configuration Game.ini over [here](https://github.com/DreamsideInteractive/FrozenFlameServer/blob/main/Game.ini) if you want to customize your server even more.
Your Game.ini file is located at: ".../frozenflame/FrozenFlame/Saved/Config/LinuxServer" (Note: this file is created after the first server start).

You can also run multiple servers with only one SteamCMD directory!

## Example Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '1348640 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 1348640 |
| GAME_PARAMS | Values to start the server | -MetaGameServerName="FrozenFlame Docker" -RconPassword="adminDocker" |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| VALIDATE | Validates the game data | true |

## Run example
```
docker run --name FrozenFlame -d \
	-p 7777:7777 -p 7777:7777/udp -p 27015:27015 -p 27015:27015/udp -p 25575:25575 \
	--env 'GAME_ID=1348640' \
	--env 'GAME_PARAMS=-MetaGameServerName="FrozenFlame Docker" -RconPassword="adminDocker"' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/frozenflame:/serverdata/serverfiles \
	ich777/steamcmd:frozenflame
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

#### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/