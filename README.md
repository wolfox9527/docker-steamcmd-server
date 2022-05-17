# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install Last Oasis and run it.

**Customer & Provider Key:** You have to first create your own Provider Key here: https://myrealm.lastoasis.gg and fill in the generated Provider Key and Custom Key in the template.

**ATTENTION:** First Startup can take very long since it downloads the gameserver files!

**Update Notice:** Simply restart the container if a newer version of the game is available.

## Example Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '920720 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 920720 |
| IDENTIFIER | Enter your preferred server identifier. | Last Oasis Docker |
| SRV_PASSWORD | Enter your preferred server password here, leave empty for no password. | Docker |
| SLOTS | Enter the maximum server slots. | 20 |
| CUSTOMER_KEY | Your Customer Key goes here (You can get your Customer Key here: https://myrealm.lastoasis.gg Log in -> click on the Hosting drop down and select Providers). | YOURCUSTOMERKEY |
| PROVIDER_KEY | Your Provider Key goes here (You can get your Provider Key here: https://myrealm.lastoasis.gg Log in -> click on the Hosting drop down -> select Providers -> click Add Key -> enter a Name and click Add). | YOURPROVIDERKEY |
| GAME_PARAMS | Values to start the server | -port=5555 -QueryPort=27015 -NoLiveServer -EnableCheats |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| VALIDATE | Validates the game data | true |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

## Run example
```
docker run --name LastOasis -d \
	-p 5555:5555/udp -p 27015:27015/udp \
	--env 'GAME_ID=232330' \
	--env 'IDENTIFIER=Last Oasis Docker' \
	--env 'SRV_PASSWORD=Docker' \
	--env 'SLOTS=20' \
	--env 'CUSTOMER_KEY=YOURCUSTOMERKEY' \
	--env 'PROVIDER_KEY=YOURPROVIDERKEY' \
	--env 'GAME_PARAMS=-port=5555 -QueryPort=27015 -NoLiveServer -EnableCheats' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/lastoasis:/serverdata/serverfiles \
	ich777/steamcmd:lastoasis
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

#### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/