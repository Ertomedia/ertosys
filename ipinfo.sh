#!/bin/bash
#
# ipinfo.sh
# ver 0.1.1
# Modified: 30-06-2020
#
# https://github.com/Ertomedia/ertosys
#
# Copyright (c) 2020 Erol Joudy. Released under the MIT License.

. common.lib

FILE="ipinfo.sh"

read -rp "»  Enter IP Address: " IPNUM

function fcurlipinfo() {
    curl --silent --show-error https://ipinfo.io/${IPNUM} | grep "$1"
}
function fcutipinfo() {
    cut -d '"' -f 4
}

kota=$(fcurlipinfo "city" | fcutipinfo);
negara=$(fcurlipinfo "country" | fcutipinfo); 
zone=$(fcurlipinfo "timezone" | fcutipinfo); 
lokasi=$(fcurlipinfo "loc" | fcutipinfo); 
isp=$(fcurlipinfo "org" | fcutipinfo); 

echo -e "»  Please select which data to display?"
select yn in "City" "Country" "Timezone" "Location" "Provider" "All Data" "Exit"; do
    case $yn in
        "City" ) 
            fnewL;
            echo "City: $kota"; 
            fnewL && frmall;
            break;;
        "Country" )
            fnewL;
            echo "Country: $negara"; 
            fnewL && frmall;
            break;;
        "Timezone" )
            fnewL;
            echo "Timezone: $zone"; 
            fnewL && frmall;
            break;;
        "Location" )
            fnewL;
            echo "Location: $lokasi"; 
            fnewL && frmall;
            break;;
        "Provider" )
            fnewL;
            echo "Provider: $isp"; 
            fnewL && frmall;
            break;;
        "All Data" )
            fnewL;
            echo "City: $kota"; 
            echo "Country: $negara"; 
            echo "Timezone: $zone"; 
            echo "Location: $lokasi"; 
            echo "Provider: $isp"; 
            fnewL && frmall;
            break;;
        "Exit" )
            fbye; # Bye message from Cortana
            frmall;
            exit;;
    esac
done