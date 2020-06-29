#!/bin/bash
#
# install_docker_ubn.sh
# ver 0.1.1
# Modified: 30-06-2020
#
# https://github.com/Ertomedia/ertosys
#
# Copyright (c) 2020 Erol Joudy. Released under the MIT License.

. common.lib

FILE="install_docker_ubn.sh"

function oscheck() { # OS Check
    fchkdistro

    if [ "$osdebn" = 'ubuntu' ]
    then
        echo "»  Installing packages..."
        sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
        sudo apt-key fingerprint 0EBFCD88 && fnewL
        echo "»  Set up the repository..."
        echo -e "${LCYAN}Choose Linux architecture?${CDEF}"
        select yn in "x86_64 / amd64" "armhf" "arm64" "ppc64el" "s390x" "Not now (Exit)"; do
            case $yn in
                "x86_64 / amd64" ) 
                    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable";
                    break;;
                armhf ) 
                    sudo add-apt-repository "deb [arch=armhf] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable";
                    break;;
                arm64 ) 
                    sudo add-apt-repository "deb [arch=arm64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable";
                    break;;
                ppc64el ) 
                    sudo add-apt-repository "deb [arch=ppc64el] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable";
                    break;;
                s390x ) 
                    sudo add-apt-repository "deb [arch=s390x] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable";
                    break;;
                Later )
                    fbye; # Bye message from Cortana
                    frmall; # remove all downloaded files
                    exit;;
            esac
        done && fnewLL
        echo "»  Installing docker engine..."
        sudo apt-get update
        sudo apt-get install -y docker-ce docker-ce-cli containerd.io && fnewLL
        echo "»  Testing docker with hello-world..."
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