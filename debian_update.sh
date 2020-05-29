#!/bin/bash
. common.lib

FILE="debian_update.sh"

DISTRO=$(sudo cat /etc/os-release | grep -w NAME | cut -d '"' -f 2)

echo "Do you wish to check for your ${DISTRO} updates now?"
select yn in "YES" "NO (Back to Main)" "Exit"; do
    case $yn in
        YES ) 
            sudo apt update -y; 
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
sleep 1
echo "Do you wish to upgrade it?"
select yn in "YES" "NO (Back to Main)" "Exit"; do
    case $yn in
        YES ) 
            sudo apt upgrade -y; 
            sudo apt dist-upgrade -y;
            sudo apt autoremove -y; 
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