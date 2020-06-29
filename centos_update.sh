#!/bin/bash
#
# centos_update.sh
# ver 0.1.1
# Modified: 30-06-2020
#
# https://github.com/Ertomedia/ertosys
#
# Copyright (c) 2020 Erol Joudy. Released under the MIT License.

. common.lib

FILE="centos_update.sh"

DISTRO=$(grep -w NAME /etc/os-release | cut -d '"' -f 2)

echo "Do you wish to check for your ${DISTRO} updates now?"
select yn in "YES" "NO (Back to Main)" "Exit"; do
    case $yn in
        YES ) 
            sudo yum check-update -y;
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
            sudo yum update -y;
            fnewL && echo "i  Removing unused packages...";
            sudo yum autoremove -y; 
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