#!/bin/bash
version=${PhantomBotVersion:="Latest"}
name="PhantomBot-${version}"

echo "running entrypoint"

if [ ! -f ${homeDir}/botlogin.txt ]; then
echo "botlogin.txt not found so downloading and configuring the files"

# todo: Remove redundancy
if [ ${version} == "Latest" ]; then
            echo "Started downloading PhantomBot version: ${version}"
            wget --header="User-Agent: Docker-build" -q -O "${homeDir}/Phantombot.zip" $(curl -s https://api.github.com/repos/PhantomBot/PhantomBot/releases | grep browser_download_url | head -n 1 | cut -d '"' -f 4)
            echo "Finished downloading"
            echo "Unzipping files"
            unzip "${homeDir}/Phantombot.zip" -d ${homeDir} \
            && mv ${homeDir}/*/* "${homeDir}" \
            && rm -rf "${homeDir}/Phantombot.zip"
                        ls ${homeDir} -all
        else
            echo "Started downloading PhantomBot version: ${version}"
            wget --header="User-Agent: Docker-build" -q -O "${homeDir}/Phantombot.zip" https://github.com/PhantomBot/PhantomBot/releases/download/v${version}/PhantomBot-${version}.zip
            echo "Finished downloading"
            echo "Unzipping files"
            unzip "${homeDir}/Phantombot.zip" -d ${homeDir} \
            && mv ${homeDir}/*/* "${homeDir}" \
            && rm -rf "${homeDir}/Phantombot.zip"
            ls ${homeDir} -all
fi
    echo "creating botlogin.txt"
    cp /scripts/botlogin.txt ${homeDir} && sed -i "s/\%BOT_USERNAME\%/${BOT_USERNAME}/g;s/\%BOT_OAUTH\%/${BOT_OAUTH}/g;s/\%BOT_CHANNEL\%/${BOT_CHANNEL}/g;s/\%BOT_OWNER\%/${BOT_OWNER}/g;" "${homeDir}/botlogin.txt"
    echo "starting bot"
    chmod +x ${homeDir}/launch-service.sh
    ${homeDir}/launch-service.sh
else
echo "Found install, starting"
    ${homeDir}/launch-service.sh
fi
