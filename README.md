# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install Operation: Harsh Doorstop and run it.

**Update Notice:** Simply restart the container if a newer version of the game is available.

## Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '950900 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 950900 |
| GAME_PARAMS | Enter your game parameters seperated with ? (don't put spaces in between eg: don't put spaces in between eg: MaxPlayers=24?AutoAssignHuman=1?bBotAutofill) | LamDong?MaxPlayers=34?AutoAssignHuman=1?bBotAutofill?bBalanceTeams=1?BluforNumBots=6?Game.AutoBalanceTeamsOverride=1 |
| GAME_PARAMS_EXTRA | Values to start the server | -server -log -SteamServerName="Docker OHDs" |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| VALIDATE | Validates the game data | true |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

## Run example
```
docker run --name Operation-HarshDoorstop -d \
	-p 7777-7778:7777-7778/udp -p 27005:27005/udp -p 7779:7779 \
	--env 'GAME_ID=950900' \
	--env 'GAME_PARAMS=LamDong?MaxPlayers=34?AutoAssignHuman=1?bBotAutofill?bBalanceTeams=1?BluforNumBots=6?Game.AutoBalanceTeamsOverride=1' \
	--env 'GAME_PARAMS_EXTRA=-server -log -SteamServerName="Docker OHDs"' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/ohds:/serverdata/serverfiles \
	ich777/steamcmd:ohds
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/