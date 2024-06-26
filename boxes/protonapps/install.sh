#! /bin/bash

set -ouex pipefail

## Global variables
DOWNLOAD_DIR="/build"
SCRIPT_DIR="/opt/utils"
JQ_PARSE_RELEASE=".Releases | sort_by(.ReleaseDate) | last"
JQ_PARSE_PACKAGE=".File[] | select(.Identifier | contains(\".rpm\")) | .Url"
JQ_PARSE_SHA512=".File[] | select(.Identifier | contains(\".rpm\")) | .Sha512CheckSum"

## Install dependencies
### this script
dnf install -y jq
### proton-apps
dnf install -y libXtst libnotify nss at-spi2-core gtk3

## Install proton mail
PROTON_MAIL_VERSION_FILE="https://proton.me/download/mail/linux/version.json"
PROTON_MAIL_RELEASE_LATEST=$(curl -s "${PROTON_MAIL_VERSION_FILE}" | jq -r "${JQ_PARSE_RELEASE}")
PROTON_MAIL_PACKAGE_URL=$(echo "${PROTON_MAIL_RELEASE_LATEST}" | jq -r "${JQ_PARSE_PACKAGE}")
PROTON_MAIL_PACKAGE_NAME=$(basename "${PROTON_MAIL_PACKAGE_URL}")
PROTON_MAIL_PACKAGE_SHA512=$(echo "${PROTON_MAIL_RELEASE_LATEST}" | jq -r "${JQ_PARSE_SHA512}")
wget -O "${DOWNLOAD_DIR}/${PROTON_MAIL_PACKAGE_NAME}" "${PROTON_MAIL_PACKAGE_URL}"
if echo "${PROTON_MAIL_PACKAGE_SHA512} ${DOWNLOAD_DIR}/${PROTON_MAIL_PACKAGE_NAME}" | sha512sum --check; then
  echo "SHA512 checksum verification successful."
  rpm -i "${DOWNLOAD_DIR}/${PROTON_MAIL_PACKAGE_NAME}"
else
  echo "SHA512 checksum verification failed. Aborting installation."
  exit 1
fi

## Install proton pass
PROTON_PASS_VERSION_FILE="https://proton.me/download/PassDesktop/linux/x64/version.json"
PROTON_PASS_RELEASE_LATEST=$(curl -s "${PROTON_PASS_VERSION_FILE}" | jq -r "${JQ_PARSE_RELEASE}")
PROTON_PASS_PACKAGE_URL=$(echo "${PROTON_PASS_RELEASE_LATEST}" | jq -r "${JQ_PARSE_PACKAGE}")
PROTON_PASS_PACKAGE_NAME=$(basename "${PROTON_PASS_PACKAGE_URL}")
PROTON_PASS_PACKAGE_SHA512=$(echo "${PROTON_PASS_RELEASE_LATEST}" | jq -r "${JQ_PARSE_SHA512}")
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