#!/bin/bash
# Modified: 24-05-2020
#
# https://source.my.id/erol/climyid
#
# Copyright (c) 2020 Erol Joudy. Released under the MIT License.

. common.lib

FILE="update.sh"

function autocheck() {
    DISTRO=$(sudo cat /etc/os-release | grep -w ID | cut -d '=' -f 2)
    DISTRO2=$(sudo cat /etc/os-release | grep -w ID | cut -d '"' -f 2)

    if [ "$DISTRO" = 'ubuntu' ]
    then
        VARU="ubuntu";
        fwget "${VARU}_${FILE} -O ${VARU}_${FILE}"; # wget from url
        fchmodx "${VARU}_${FILE}" && ./${VARU}_${FILE}; # make file executable and execute it
        frmfile; # remove THIS file
    
    elif [ "$DISTRO" = 'kali' ]
    then
        VARK="kali";
        fwget "${VARK}_${FILE} -O ${VARK}_${FILE}"; 
        fchmodx "${VARK}_${FILE}" && ./${VARK}_${FILE};
        frmfile;
    
    elif [ "$DISTRO" = 'debian' ]
    then
        VARD="debian";
        fwget "${VARD}_${FILE} -O ${VARD}_${FILE}"; 
        fchmodx "${VARD}_${FILE}" && ./${VARD}_${FILE};
        frmfile;
    
    elif [ "$DISTRO2" = 'centos' ]
    then
        VARC="centos";
        fwget "${VARC}_${FILE} -O ${VARC}_${FILE}"; 
        fchmodx "${VARC}_${FILE}" && ./${VARC}_${FILE}; 
        frmfile;
    
    else
        fnewL # single line break
        echo "Unable to define your distro! Wanna try our supported update script close to your distro?"
        select yn in "CentOS..." "Debian..." "Ubuntu..." "Kali..." "NO (Back to Main)" "Exit"; do
            case $yn in
                "CentOS..." ) 
                    VARC="centos";
                    fwget "${VARC}_${FILE} -O ${VARC}_${FILE}"; 
                    fchmodx "${VARC}_${FILE}" && ./${VARC}_${FILE}; 
                    frmfile;
                    break;;
                "Debian..." ) 
                    VARD="debian";
                    fwget "${VARD}_${FILE} -O ${VARD}_${FILE}"; 
                    fchmodx "${VARD}_${FILE}" && ./${VARD}_${FILE};
                    frmfile;
                    break;;
                "Ubuntu..." ) 
                    VARU="ubuntu";
                    fwget "${VARU}_${FILE} -O ${VARU}_${FILE}"; 
                    fchmodx "${VARU}_${FILE}" && ./${VARU}_${FILE};
                    frmfile;
                    break;;
                "Kali..." ) 
                    VARK="kali";
                    fwget "${VARK}_${FILE} -O ${VARK}_${FILE}"; 
                    fchmodx "${VARK}_${FILE}" && ./${VARK}_${FILE};
                    frmfile;
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
    fi
}

fnewL
echo "» Okay, checking your distro version..."
autocheck