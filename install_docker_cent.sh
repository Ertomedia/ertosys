#!/bin/bash
# Modified: 24-05-2020

. common.lib

FILE="install_docker_cent.sh"

function oscheck() { # OS Check
    catdistro

    if test "$CATOSx" = 'centos'
    then
        echo "» Installing packages..."
        sudo yum install -y yum-utils
        sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo && fnewL
        echo "» Installing docker engine..."
        sudo yum install -y docker-ce docker-ce-cli containerd.io
        sudo systemctl start docker && fnewLL
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