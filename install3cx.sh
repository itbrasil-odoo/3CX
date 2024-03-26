#!/bin/bash
set -eu

###################################################################
#Script Name    : install3cx.sh
#Description    : Install 3CX on Debian 12
#Author         : Renan Teixeira
#Email          : contato@renanteixeira.com.br
#Version        : 0.2 - 2024-03-26
###################################################################

#Global variables
GREEN="\e[92m"
RED="\e[31m"
END="\e[0m"
BLUE="\e[34m"
YELLOW="\e[33m"

center() {
        termwidth="$(tput cols)"
        padding="$(printf '%0.1s' ={1..500})"
        printf '%*.*s %s %*.*s\n' 0 "$(((termwidth-2-${#1})/2))" "$padding" "$1" 0 "$(((termwidth-1-${#1})/2))" "$padding"
}

printf "${GREEN}"
center "Update System"
printf "${END}"

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt autoremove -y

printf "${BLUE}"
center "Install Dependences"
printf "${END}"

sudo apt-get install -y wget gnupg2 net-tools dphys-swapfile

printf "${GREEN}"
center "Add 3CX Repository to Debian 12"
printf "${END}"
wget -O- https://repo.3cx.com/key.pub | gpg --dearmor | sudo tee /usr/share/keyrings/3cx-archive-keyring.gpg > /dev/null
echo "deb [arch=amd64 by-hash=yes signed-by=/usr/share/keyrings/3cx-archive-keyring.gpg] http://repo.3cx.com/3cx bookworm main" | sudo tee /etc/apt/sources.list.d/3cxpbx.list

sudo apt-get update

printf "${BLUE}"
center "Install 3CX"
printf "${END}"
sudo apt-get install -y 3cxpbx
