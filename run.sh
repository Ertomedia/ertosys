#!/bin/bash

FILE="run.sh"
CDEF="\e[39m"
LCYAN="\e[96m"
LRED="\e[91m"

# Pre-check
fdistrochk() {
    TITLE="${LCYAN}i  Pre-check:${CDEF}"
    osdebn=$(grep -w ID /etc/os-release | cut -d '=' -f 2)
    osrhel=$(grep -w ID /etc/os-release | cut -d '"' -f 2)

    if [[ "$osdebn" = 'ubuntu' ]]
    then
        ## Check curl if exist
        if [ ! -f /usr/bin/curl ]; then
            echo "${TITLE} CURL not found. Installing..."
            sudo apt install -y -q curl
        fi

    elif [[ "$osdebn" = 'debian' ]]
    then
        ## Check curl if exist
        if [ ! -f /usr/bin/curl ]; then
            echo "${TITLE} CURL not found. Installing..."
            sudo apt install -y -q curl
        fi

    elif [[ "$osrhel" = 'centos' ]]
    then
        ## Check curl if exist
        if [ ! -f /usr/bin/curl ]; then
            echo "${TITLE} CURL not found. Installing..."
            yum -y -q install curl
        fi

    elif [[ "$osrhel" = 'fedora' ]]
    then
        ## Check curl if exist
        if [ ! -f /usr/bin/curl ]; then
            echo "${TITLE} CURL not found. Installing..."
            yum -y -q install curl
        fi

    else
        printf "\n"
        echo -e "${LRED}Sorry, your Distro is not supported yet. Exiting now.${CDEF}"
        echo -e "${LCYAN}See you later.${CDEF}" # Bye message from Cortana
        rm -fR $FILE # remove all downloaded files
    fi
}
fdistrochk

## Fetching required files to run
sudo wget -q https://static.cli.my.id/common.lib
sudo wget -q https://static.cli.my.id/climyid.sh
sudo chmod +x climyid.sh
./climyid.sh