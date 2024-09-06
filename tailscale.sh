echo
if [[ ! -f /usr/bin/tailscale || ! -f /usr/bin/tailscaled ]]; then
  echo "Installing dependencies..."
  echo "Please wait..."
  apt-get update >/dev/null 2>&1
  apt-get -y install --no-install-recommends jq wget >/dev/null 2>&1
  echo "Done"

  echo "Tailscale not found, downloading..."
  echo "Please wait..."

  TAILSCALE_JSON=$(wget -qO- 'https://pkgs.tailscale.com/stable/?mode=json')

  if [ -z "${TAILSCALE_JSON}" ]; then
    echo "ERROR: Can't get Tailscale JSON"
    exit 1
  fi

  TAILSCALE_TARBALL=$(echo "${TAILSCALE_JSON}" | jq -r .Tarballs.amd64)
  TAILSCALE_VERSION=$(echo "${TAILSCALE_JSON}" | jq -r .TarballsVersion)

  if [ ! -d /tmp/tailscale ]; then
    mkdir -p /tmp/tailscale
  fi

  if wget -q -nc --show-progress --progress=bar:force:noscroll -O /tmp/tailscale/tailscale.tgz "https://pkgs.tailscale.com/stable/${TAILSCALE_TARBALL}" ; then
    echo "Download from Tailscale version ${TAILSCALE_VERSION} successful!"
  else
    echo "ERROR: Download from Tailscale version ${TAILSCALE_VERSION} failed!"
    rm -rf /tmp/tailscale
  fi

  cd /tmp/tailscale
  tar -xf /tmp/tailscale/tailscale.tgz
  cp /tmp/tailscale/tailscale_${TAILSCALE_VERSION}_amd64/tailscale /usr/bin/tailscale
  cp /tmp/tailscale/tailscale_${TAILSCALE_VERSION}_amd64/tailscaled /usr/bin/tailscaled
  rm -rf /tmp/tailscale

  echo "Done"

else
  echo "Tailscale found, continuing..."
fi

if [ -v SERVER_DIR ]; then
  TSD_STATE_DIR=${SERVER_DIR}/.tailscale_state
  if [ ! -d ${TS_STATE_DIR} ]; then
    mkdir -p ${TS_STATE_DIR}
  fi
  echo "Settings Tailscale state dir to: ${TSD_STATE_DIR}"
elif [ -v DATA_DIR ]; then
  TSD_STATE_DIR=${DATA_DIR}/.tailscale_state
  if [ ! -d ${TS_STATE_DIR} ]; then
    mkdir -p ${TS_STATE_DIR}
  fi
  echo "Settings Tailscale state dir to: ${TSD_STATE_DIR}"
else
  if [ -z "${TAILSCALE_STAT_DIR}" ]; then
    TAILSCALE_STATE_DIR="/config/.tailscale_state"
  fi
  TSD_STATE_DIR=${TAILSCALE_STATE_DIR}
  if [ ! -d ${TS_STATE_DIR} ]; then
    mkdir -p ${TS_STATE_DIR}
  fi
  echo "Settings Tailscale state dir to: ${TSD_STATE_DIR}"
fi

if [ "${TAILSCALE_LOG}" != "false" ]; then
  TAILSCALED_PARAMS=">>/var/log/tailscaled 2>&1 "
  TSD_MSG=" with log file /var/log/tailscaled"
else
  TAILSCALED_PARAMS=">/dev/null 2>&1 "
fi

if [ -z "${TAILSCALE_KEY}" ]; then
  echo "ERROR: No Authorization key defined!"
  exit 1
fi

if [ ! -z "${TAILSCALE_HOSTNAME}" ]; then
  echo "Setting host name to ${TAILSCALE_HOSTNAME}"
  TAILSCALE_PARAMS="--hostname=${TAILSCALE_HOSTNAME}"
fi

echo "Starting tailscaled${TSD_MSG}"
eval tailscaled -tun=userspace-networking -statedir=${TSD_STATE_DIR} ${TAILSCALED_PARAMS}&

echo "Starting tailscale"
eval tailscale up --authkey=${TAILSCALE_KEY} ${TAILSCALE_PARAMS}
