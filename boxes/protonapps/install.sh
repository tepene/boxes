#! /bin/bash

set -ouex pipefail

## Global variables
DOWNLOAD_DIR="/box"
SCRIPT_DIR="/opt/box"

## Install dependencies
### this script
dnf install -y jq
### proton-pass
dnf install -y libXtst libnotify nss at-spi2-core gtk3 # proton-pass

## Install proton pass
PROTON_PASS_VERSION_FILE="https://proton.me/download/PassDesktop/linux/x64/version.json"
PROTON_PASS_RELEASE_LATEST=$(curl -s "${PROTON_PASS_VERSION_FILE}" | jq -r '.Releases | sort_by(.ReleaseDate) | last')
PROTON_PASS_PACKAGE_URL=$(echo "${PROTON_PASS_RELEASE_LATEST}" | jq -r '.File[] | select(.Identifier | contains(".rpm")) | .Url')
PROTON_PASS_PACKAGE_NAME=$(basename "${PROTON_PASS_PACKAGE_URL}")
PROTON_PASS_PACKAGE_SHA512=$(echo "${PROTON_PASS_RELEASE_LATEST}" | jq -r '.File[] | select(.Identifier | contains(".rpm")) | .Sha512CheckSum')
wget -O "${DOWNLOAD_DIR}/${PROTON_PASS_PACKAGE_NAME}" "${PROTON_PASS_PACKAGE_URL}"
if echo "${PROTON_PASS_PACKAGE_SHA512} ${DOWNLOAD_DIR}/${PROTON_PASS_PACKAGE_NAME}" | sha512sum --check; then
  echo "SHA512 checksum verification successful."
  rpm -i --force "${DOWNLOAD_DIR}/${PROTON_PASS_PACKAGE_NAME}"
else
  echo "SHA512 checksum verification failed. Aborting installation."
  exit 1
fi

## Additional build steps
SHELL_SCRIPTS=$(find "${SCRIPT_DIR}" -type f -name "*.sh")
for __FILE in "${SHELL_SCRIPTS[@]}"; do
  chmod +x "${__FILE}"
done