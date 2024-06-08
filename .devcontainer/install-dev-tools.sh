#! /bin/bash

# Bash colors
RED="\e[31m"
YELLOW="\e[33m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"

## Update system
echo ""
echo -e "${YELLOW}Updating OS${ENDCOLOR}"
echo ""
sudo apt-get update && sudo apt-get upgrade -y

## Install additional tools
echo ""
echo -e "${YELLOW}Installing additional tools${ENDCOLOR}"
echo ""
sudo apt-get -y install --no-install-recommends git-extras gnupg2 shellcheck

## lazygit -> version specified in devcontainer.json
LAZYGIT_SOURCE="https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
LAZYGIT_TMP="/tmp/lazygit.tar.gz"
wget -O "${LAZYGIT_TMP}" "${LAZYGIT_SOURCE}"
sudo tar -xf "${LAZYGIT_TMP}" -C /usr/bin

## cosign
COSIGN_SOURCE="https://github.com/sigstore/cosign/releases/latest/download/cosign-linux-amd64"
COSIGN_TMP="/tmp/cosign"
wget -O "${COSIGN_TMP}" "${COSIGN_SOURCE}"
sudo mv "${COSIGN_TMP}" /usr/bin
sudo chmod +x /usr/bin/cosign

# Add git commit template
echo ""
echo -e "${YELLOW}Configuring git${ENDCOLOR}"
echo ""
git config --local commit.template .gitmessage

# Finish
echo ""
echo -e "${GREEN}Done. Happy coding!${ENDCOLOR}"
echo ""