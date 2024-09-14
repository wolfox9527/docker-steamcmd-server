#!/bin/bash
# The script will then add the container to your Tailscale network.
#
# For more information see: [Link TBD]

echo
if [[ ! -f /usr/bin/tailscale || ! -f /usr/bin/tailscaled ]]; then
  if [ ! -z "${TAILSCALE_EXIT_NODE_IP}" ]; then
    if [ ! -c /dev/net/tun ]; then
      echo "ERROR: Device /dev/net/tun not found!"
      echo "       Make sure to pass through /dev/net/tun to the container."
      exit 1
    fi
    APT_IPTABLES="iptables "
  fi

  echo "Detecting Package Manager..."
  if which apt-get >/dev/null 2>&1; then
    echo "Detected Advanced Package Tool!"
    UPDATE_CMD="apt-get update"
    INSTALL_CMD="apt-get -y install --no-install-recommends"
  elif which apk >/dev/null 2>&1; then
    echo "Detected Alpine Package Keeper!"
    PACKAGES_UPDATE="apk update"
    PACKAGES_INSTALL="apk add"
  else
    echo "ERROR: Detection failed!"
    exit 1
  fi

  echo "Installing dependencies..."
  echo "Please wait..."
  ${PACKAGES_UPDATE} >/dev/null 2>&1
  ${PACKAGES_INSTALL} jq wget ${APT_IPTABLES}>/dev/null 2>&1
  echo "Done"

  if [ "${APT_IPTABLES}" == "iptables " ]; then
    if ! iptables -L >/dev/null 2>&1; then
      echo "ERROR: Cap: NET_ADMIN not available!"
      echo "       Make sure to add --cap-add=NET_ADMIN to the Extra Parameters"
      exit 1
    fi
  fi

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
    exit 1
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

unset TSD_PARAMS
unset TS_PARAMS

if [ -v SERVER_DIR ]; then
  TSD_STATE_DIR=${SERVER_DIR}/.tailscale_state
  echo "Settings Tailscale state dir to: ${TSD_STATE_DIR}"
elif [ -v DATA_DIR ]; then
  TSD_STATE_DIR=${DATA_DIR}/.tailscale_state
  echo "Settings Tailscale state dir to: ${TSD_STATE_DIR}"
else
  if [ -z "${TAILSCALE_STAT_DIR}" ]; then
    TAILSCALE_STATE_DIR="/config/.tailscale_state"
  fi
  TSD_STATE_DIR=${TAILSCALE_STATE_DIR}
  echo "Settings Tailscale state dir to: ${TSD_STATE_DIR}"
fi

if [ ! -d ${TS_STATE_DIR} ]; then
  mkdir -p ${TS_STATE_DIR}
fi

if [ ! -z "${TAILSCALE_EXIT_NODE_IP}" ]; then
  echo "Using ${TAILSCALE_EXIT_NODE_IP} as Exit Node! See https://tailscale.com/kb/1103/exit-nodes"
  TS_PARAMS=" --exit-node=${TAILSCALE_EXIT_NODE_IP}"
  if [ ! -z "${TAILSCALE_ALLOW_LAN_ACCESS}" ]; then
    echo "Enabling local LAN Access to the container!"
    TS_PARAMS+=" --exit-node-allow-lan-access"
  fi
else
  if [ -z "${TAILSCALE_USERSPACE_NETWORKING}" ] || [ "${TAILSCALE_USERSPACE_NETWORKING}" == "true" ]; then
    TSD_PARAMS+="-tun=userspace-networking "
  else
    if [ ! -c /dev/net/tun ]; then
      echo "ERROR: Device /dev/net/tun not found!"
      echo "       Make sure to pass through /dev/net/tun to the container and add the"
      echo "       parameter --cap-add=NET_ADMIN to the Extra Parameters!"
      exit 1
    fi
  fi
fi

if [ "${TAILSCALE_USE_SSH}" == "true" ]; then
  echo "Enabling SSH. See https://tailscale.com/kb/1193/tailscale-ssh"
  TS_PARAMS+=" --ssh"
fi

if [ "${TAILSCALE_LOG}" != "false" ]; then
  TSD_PARAMS+=">>/var/log/tailscaled 2>&1 "
  TSD_MSG=" with log file /var/log/tailscaled"
else
  TSD_PARAMS+=">/dev/null 2>&1 "
fi

if [ -z "${TAILSCALE_AUTHKEY}" ]; then
  echo "ERROR: No Authorization key defined! See https://tailscale.com/kb/1085/auth-keys#generate-an-auth-key"
  exit 1
fi

if [ ! -z "${TAILSCALE_HOSTNAME}" ]; then
  echo "Setting host name to ${TAILSCALE_HOSTNAME}"
  TS_PARAMS+=" --hostname=${TAILSCALE_HOSTNAME/ /}"
fi

if [ "${TAILSCALE_EXIT_NODE}" == "true" ]; then
  echo "Configuring container as Exit Node! See https://tailscale.com/kb/1103/exit-nodes"
  TS_PARAMS+=" --advertise-exit-node"
fi

if [ ! -z "${TAILSCALED_PARAMS}" ]; then
  TSD_PARAMS="${TAILSCALED_PARAMS} ${TSD_PARAMS}"
fi

if [ ! -z "${TAILSCALE_PARAMS}" ]; then
  TS_PARAMS="${TAILSCALE_PARAMS}${TS_PARAMS}"
fi

echo "Starting tailscaled${TSD_MSG}"
eval tailscaled -statedir=${TSD_STATE_DIR} ${TSD_PARAMS}&

echo "Starting tailscale"
eval tailscale up --authkey=${TAILSCALE_AUTHKEY} ${TS_PARAMS}

if [[ ! -z "${TAILSCALE_SERVE_PORT}" && "$(tailscale status --json | jq -r '.CurrentTailnet.MagicDNSEnabled')" == "false" ]] ; then
  echo "ERROR: Enable HTTPS on your Tailscale account to use Tailscale Serve/Funnel."
  echo "See: https://tailscale.com/kb/1153/enabling-https"
  exit 1
fi

if [ ! -z ${TAILSCALE_SERVE_PORT} ]; then
  if [ ! -z "${TAILSCALE_SERVE_PATH}" ]; then
    TAILSCALE_SERVE_PATH="=${TAILSCALE_SERVE_PATH}"
  fi
  if [ -z "${TAILSCALE_SERVE_MODE}" ]; then
    TAILSCALE_SERVE_MODE="https"
  fi
  if [ "${TAILSCALE_FUNNEL}" == "true" ]; then
    echo "Enabling Funnel! See https://tailscale.com/kb/1223/funnel"
    eval tailscale funnel --bg --"${TAILSCALE_SERVE_MODE}"=443${TAILSCALE_SERVE_PATH} http://localhost:"${TAILSCALE_SERVE_PORT}${TAILSCALE_SERVER_LOCALPATH}"
  else
    echo "Enabling Serve! See https://tailscale.com/kb/1312/serve"
    eval tailscale serve --bg --"${TAILSCALE_SERVE_MODE}"=443${TAILSCALE_SERVE_PATH} http://localhost:"${TAILSCALE_SERVE_PORT}${TAILSCALE_SERVER_LOCALPATH}"
  fi
fi
