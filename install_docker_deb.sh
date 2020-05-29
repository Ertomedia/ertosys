#!/bin/bash
# Modified: 24-05-2020

. common.lib

FILE="install_docker_deb.sh"

function oscheck() { # OS Check
    catdistro

    if test "$CATOS" = 'debian'
    then
        echo "» Installing packages..."
        sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
        curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
        sudo apt-key fingerprint 0EBFCD88 && fnewL
        echo "» Set up the repository..." && fnewLL
        echo -e "${LCYAN}Choose our machine architecture?${CDEF}"
        select yn in "x86_64 / amd64" "armhf" "arm64" "Later"; do
            case $yn in
                "x86_64 / amd64" ) 
                    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable";
                    break;;
                armhf ) 
                    sudo add-apt-repository "deb [arch=armhf] https://download.docker.com/linux/debian $(lsb_release -cs) stable";
                    break;;
                arm64 ) 
                    sudo add-apt-repository "deb [arch=arm64] https://download.docker.com/linux/debian $(lsb_release -cs) stable";
                    break;;
                Later )
                    fbye; # Bye message from Cortana
                    frmall; # remove all downloaded files
                    exit;;
            esac
        done && fnewLL
        echo "» Installing docker engine..."
        sudo apt-get update
        sudo apt-get install -y docker-ce docker-ce-cli containerd.io && fnewLL
        echo "» Testing docker with hello-world..."
        sudo docker run hello-world
        fdone # finished operation message
        frmall # remove all downloaded CLIMYID files

    else
        fnewL
        fnosupport
        fbye # Bye message from Cortana
        frmall # remove all downloaded files
    fi
}

oscheck