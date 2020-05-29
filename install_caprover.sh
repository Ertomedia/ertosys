#!/bin/bash
#
# https://source.my.id/erol/climyid
#
# Copyright (c) 2020 Erol Joudy. Released under the MIT License.

. common.lib

FILE="install_caprover.sh"
VER_NPM="14"

function oscheck() { # Detect OS

    if grep -qs "ubuntu" /etc/os-release; then
        os="ubuntu"
        os_version=$(grep 'VERSION_ID' /etc/os-release | cut -d '"' -f 2 | tr -d '.')
    # elif [[ -e /etc/debian_version ]]; then
    #     os="debian"
    #     os_version=$(grep -oE '[0-9]+' /etc/debian_version | head -1)
    # elif [[ -e /etc/centos-release ]]; then
    #     os="centos"
    #     os_version=$(grep -oE '[0-9]+' /etc/centos-release | head -1)
    # elif [[ -e /etc/fedora-release ]]; then
    #     os="fedora"
    #     os_version=$(grep -oE '[0-9]+' /etc/fedora-release | head -1)
    else
        echo "Looks like you aren't running this installer on Ubuntu, Debian, or CentOS"
        exit
    fi
    
    if [[ "$os" = "ubuntu" ]]
    then
        if [[ "$os_version" -lt 1604 ]]; then
            echo "Ubuntu 16.04 or higher is required to use this installer
        This version is too old and unsupported"
            exit
        fi
        echo "» Configuring firewall..."
        # Check UFW status
        UFW=$(sudo service ufw status | grep 'Active' | awk '{print $3}');
        if test "$UFW" = "(running)"
        then
            systemctl stop ufw.service

        else
            sudo apt install -y ufw
        fi
        ufw allow 80,443,3000,996,7946,4789,2377/tcp; ufw allow 7946,4789,2377/udp
        sudo systemctl enable ufw.service && sudo systemctl start ufw.service && fnewL
        echo "» Installing CapRover..."
        docker run -p 80:80 -p 443:443 -p 3000:3000 -v /var/run/docker.sock:/var/run/docker.sock -v /captain:/captain caprover/caprover && fnewL
        echo "» Detecting NPM..."
        # Check NPM status
        NPM=$(sudo service ufw status | grep 'Active' | awk '{print $3}')
        if test "$NPM" = "(running)"
        then
            npm install -g caprover

        else
            sudo curl -sL https://deb.nodesource.com/setup_"${VER_NPM}".x | sudo -E bash -
            sudo apt install nodejs -y && npm install -g caprover
        fi
        caprover serversetup
        frmall # remove all downloaded CLIMYID files

    else
        fnewL
        echo -e "${LCYAN}Ubuntu 16.04 or higher is required to use this installer
        This version of Ubuntu is too old and unsupported. Exiting now.${CDEF}"
        fbye # Bye message from Cortana
        frmall # remove all downloaded files
    fi
}

oscheck