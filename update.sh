#!/bin/bash
#
# update.sh
# ver 0.1.1
# Modified: 30-06-2020
#
# https://github.com/Ertomedia/ertosys
#
# Copyright (c) 2020 Erol Joudy. Released under the MIT License.

. common.lib

FILE="update.sh"

autocheck() {
    osdebn=$(grep -w ID /etc/os-release | cut -d '=' -f 2)
    osrhel=$(grep -w ID /etc/os-release | cut -d '"' -f 2)

    if [ "$osdebn" = 'ubuntu' ]
    then
        VARU="ubuntu";
        fwget "${VARU}_${FILE} -O ${VARU}_${FILE}"; # wget from url
        fchmodx "${VARU}_${FILE}" && ./${VARU}_${FILE}; # make file executable and execute it
        frmfile; # remove THIS file
    
    elif [ "$osdebn" = 'kali' ]
    then
        VARK="kali";
        fwget "${VARK}_${FILE} -O ${VARK}_${FILE}"; 
        fchmodx "${VARK}_${FILE}" && ./${VARK}_${FILE};
        frmfile;
    
    elif [ "$osdebn" = 'debian' ]
    then
        VARD="debian";
        fwget "${VARD}_${FILE} -O ${VARD}_${FILE}"; 
        fchmodx "${VARD}_${FILE}" && ./${VARD}_${FILE};
        frmfile;
    
    elif [ "$osrhel" = 'centos' ]
    then
        VARC="centos";
        fwget "${VARC}_${FILE} -O ${VARC}_${FILE}"; 
        fchmodx "${VARC}_${FILE}" && ./${VARC}_${FILE}; 
        frmfile;
    
    else
        fnewL # single line break
        echo "i  Unable to define your distro! Wanna try our supported update script close to your distro?"
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
echo "i  Execute distro pre-check..."
autocheck