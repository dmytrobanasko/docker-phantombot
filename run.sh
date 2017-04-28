#!/bin/bash

###
# Name of the bot
bot_name=""
# oauth token get one from  www.twitchapps.com/tmi/
oauth_key="oauth:xxx"
# channel name
bot_channel=""
# owner name
bot_owner=""
# webserver port
webPort=25005
# panel websocket port
panelWebsockPort=25004
# youtube websocket port
youtubeWebsocketPort=25003
###

###
# add -e 'PhantomBotVersion=<version>' see phantombot versions @github to specify a version, by default it will grab the latest available version.
###

cat << EOF

docker run -d \
-e 'BOT_USERNAME=${bot_name}' \
-e 'BOT_OAUTH=${oauth_key}' \
-e 'BOT_CHANNEL=${bot_channel}' \
-e 'BOT_OWNER=${bot_owner}' \
-v ~/docker/data/phantombot:/PhantomBot \
-p ${webPort}:${webPort} \
-p ${panelWebsockPort}:${panelWebsockPort} \
-p ${youtubeWebsocketPort}:${youtubeWebsocketPort} \
--name=phantombot d3lta/phantombot

EOF
