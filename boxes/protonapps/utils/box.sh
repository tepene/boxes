#! /bin/bash

## Variables
SCRIPT_DIR=$(dirname "$(realpath "$0")")
QUADLET_DIR="${HOME}/.config/containers/systemd"
QUADLET_NAME="protonapps-quadlet"
QUADLET_FILE="${QUADLET_NAME}.container"
QUADLET_SERVICE="${QUADLET_NAME}.service"

## Export apps
distrobox-export --app proton-pass

## Systemd quadlet
mkdir -p "${QUADLET_DIR}"
cp -f "${SCRIPT_DIR}/${QUADLET_FILE}" "${QUADLET_DIR}"
distrobox-host-exec systemctl --user daemon-reload 
distrobox-host-exec systemctl --user start "${QUADLET_SERVICE}"
