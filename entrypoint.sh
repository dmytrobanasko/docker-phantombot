#!/bin/bash
version=${PB_VERSION:="Latest"}
name="PhantomBot-${version}"

echo "Running Entrypoint"

if [ ! -f ${HOMEDIR}/botlogin.txt ]; then
  echo "botlogin.txt not found so downloading and configuring the files"

  # todo: Remove redundancy
  if [ ${version} == "Latest" ]; then
    echo "Started downloading PhantomBot version: ${version}"
    wget --header="User-Agent: Docker-build" -q -O "${HOMEDIR}/Phantombot.zip" $(curl -s https://api.github.com/repos/PhantomBot/PhantomBot/releases | grep browser_download_url | head -n 1 | cut -d '"' -f 4)
    echo "Finished downloading"
    echo "Unzipping files"
    unzip "${HOMEDIR}/Phantombot.zip" -d ${HOMEDIR} \
    && mv ${HOMEDIR}/*/* "${HOMEDIR}" \
    && rm -rf "${HOMEDIR}/Phantombot.zip"
    ls ${HOMEDIR} -all
  else
    echo "Started downloading PhantomBot version: ${version}"
    wget --header="User-Agent: Docker-build" -q -O "${HOMEDIR}/Phantombot.zip" https://github.com/PhantomBot/PhantomBot/releases/download/v${version}/PhantomBot-${version}.zip
    echo "Finished downloading"
    echo "Unzipping files"
    unzip "${HOMEDIR}/Phantombot.zip" -d ${HOMEDIR} \
    && mv ${HOMEDIR}/*/* "${HOMEDIR}" \
    && rm -rf "${HOMEDIR}/Phantombot.zip"
    ls ${HOMEDIR} -all
  fi

  echo "Creating botlogin.txt"
  cp /scripts/botlogin.txt ${HOMEDIR} && sed -i "s/\%BOT_USERNAME\%/${BOT_USERNAME}/g;s/\%BOT_OAUTH\%/${BOT_OAUTH}/g;s/\%BOT_CHANNEL\%/${BOT_CHANNEL}/g;s/\%BOT_OWNER\%/${BOT_OWNER}/g;" "${HOMEDIR}/botlogin.txt"
  echo "Starting Bot"
  cat ${HOMEDIR}/botlogin.txt
  chmod +x ${HOMEDIR}/launch-service.sh
  ${HOMEDIR}/launch-service.sh
else
  echo "Found install, starting"
  cat ${HOMEDIR}/botlogin.txt
  ${HOMEDIR}/launch-service.sh
fi
