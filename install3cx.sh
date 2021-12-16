#!/bin/bash
set -eu

###################################################################
#Script Name	: install3cx.sh
#Description	: Install 3CX on Debian 10
#Author       	: Renan Teixeira
#Email         	: contato@renanteixeira.com.br
#Version        : 0.1 - 2021-12-09
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

sudo apt-get install -y gnupg  gnupg2 gnupg1 net-tools dphys-swapfile

printf "${GREEN}"
center "Add 3CX Repository to Debian 10"
printf "${END}"
wget -O- http://downloads-global.3cx.com/downloads/3cxpbx/public.key | sudo apt-key add -
echo "deb http://downloads-global.3cx.com/downloads/debian buster main" | sudo tee /etc/apt/sources.list.d/3cxpbx.list

sudo apt-get update

printf "${BLUE}"
center "Install 3CX"
printf "${END}"
sudo apt-get install -y 3cxpbx
