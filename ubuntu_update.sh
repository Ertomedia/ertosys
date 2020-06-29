#!/bin/bash
#
# ubuntu_update.sh
# ver 0.1.1
# Modified: 30-06-2020
#
# https://github.com/Ertomedia/ertosys
#
# Copyright (c) 2020 Erol Joudy. Released under the MIT License.

. common.lib

FILE="ubuntu_update.sh"

DISTRO=$(grep -w NAME /etc/os-release | cut -d '=' -f 2)

echo "»  Do you wish to check for your ${DISTRO} updates now?"
select yn in "YES" "NO (Back to Main)" "Exit"; do
    case $yn in
        YES ) 
            sudo apt update -y; 
            fnewL;
            apt list --upgradeable; 
            frmfile; # remove THIS file
            break;;
        "NO (Back to Main)" ) 
            ./climyid.sh && frmfile;
            exit;;
        Exit ) 
            fbye; # bye message
            frmall; # remove all downloaded CLIMYID files
            exit;;
    esac
done
fnewL && sleep 1
echo "»  Proceed to upgrade?"
select yn in "YES" "NO (Back to Main)" "Exit"; do
    case $yn in
        YES ) 
            sudo apt upgrade -y; 
            sudo apt dist-upgrade -y;
            fnewL && echo "i  Removing unused packages...";
            sudo apt autoremove -y; 
            fnewL && fdone && fnewL;
            frmall;
            break;;
        "NO (Back to Main)" ) 
            ./climyid.sh && frmfile;
            exit;;
        Exit ) 
            fbye;
            frmall;
            exit;;
    esac
done