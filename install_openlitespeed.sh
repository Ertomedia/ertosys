#!/bin/bash
#
# install_openlitespeed.sh
# ver 0.1.1 (ALPHA)
# Modified: 30-06-2020
#
# https://github.com/Ertomedia/ertosys
#
# Copyright (c) 2020 Erol Joudy. Released under the MIT License.

. common.lib

FILE="install_openlitespeed.sh"

function oscheck() { # Detect OS

    if grep -qs "ubuntu" /etc/os-release; then
        os="ubuntu"
        os_version=$(grep 'VERSION_ID' /etc/os-release | cut -d '"' -f 2 | tr -d '.')
    elif [[ -e /etc/debian_version ]]; then
        os="debian"
        os_version=$(grep -oE '[0-9]+' /etc/debian_version | head -1)
    elif [[ -e /etc/centos-release ]]; then
        os="centos"
        os_version=$(grep -oE '[0-9]+' /etc/centos-release | head -1)
    # elif [[ -e /etc/fedora-release ]]; then
    #     os="fedora"
    #     os_version=$(grep -oE '[0-9]+' /etc/fedora-release | head -1)
    else
        echo "Looks like you aren't running this installer on Ubuntu, Debian, or CentOS"
        exit
    fi
    
    if [[ "$os" = "ubuntu" ]]
    then
        if [[ "$os_version" -ge 1604 ]]; then
            echo "» Installing packages..."
            wget -O - http://rpms.litespeedtech.com/debian/enable_lst_debian_repo.sh | bash 
            sudo apt install -y openlitespeed && fnewLL
            fdone # finished operation message
            frmall # remove all downloaded CLIMYID files

        elif [[ "$os_version" -lt 1604 ]]; then
            echo "Ubuntu 16.04 or higher is required to use this installer. This version is too old and unsupported."
            exit
        fi

    elif [[ "$os" = "debian" ]]
    then
        if [[ "$os_version" -ge 7 ]]; then
            echo "» Installing packages..."
            wget -O - http://rpms.litespeedtech.com/debian/enable_lst_debian_repo.sh | bash 
            sudo apt install -y openlitespeed && fnewLL
            fdone # finished operation message
            frmall # remove all downloaded CLIMYID files

        elif [[ "$os_version" -lt 7 ]]; then
            echo "Debian 7 or higher is required to use this installer. This version is too old and unsupported."
            exit
        fi

    elif [[ "$os" = "centos" ]]
    then
        if [[ "$os_version" = 7 ]]
        then
            echo "» Installing packages..."
            rpm -Uvh http://rpms.litespeedtech.com/centos/litespeed-repo-1.1-1.el7.noarch.rpm 
            yum install -y openlitespeed && fnewLL
            fdone # finished operation message
            frmall # remove all downloaded CLIMYID files
            exit
        
        elif [[ "$os_version" = 8 ]]
        then
            echo "» Installing packages..."
            rpm -Uvh http://rpms.litespeedtech.com/centos/litespeed-repo-1.1-1.el8.noarch.rpm 
            yum install -y openlitespeed && fnewLL
            fdone # finished operation message
            frmall # remove all downloaded CLIMYID files
            exit
        
        else
            echo "CentOS 7, 8 or higher is required to use this installer. This version is unsupported."
            exit
        fi

    else
        f1baris
        echo -e "${LCYAN}Ubuntu 16.04 or higher is required to use this installer
        This version of Ubuntu is too old and unsupported. Exiting now.${CDEF}"
        fbye # Bye message from Cortana
        frmall # remove all downloaded files
    fi
}

oscheck