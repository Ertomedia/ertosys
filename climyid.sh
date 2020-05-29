#!/bin/bash
# Modified: 24-05-2020
#
# https://source.my.id/erol/climyid
#
# Copyright (c) 2020 Erol Joudy. Released under the MIT License.

. common.lib

clear
VER="0.6alpha"
FILE="climyid.sh"
DESC="A simple CLI tool for various sysadmin task."

## Start Header ##
flogo
echo -e "» CLIMYID ${INV} ${VER} ${DEF}" && fnewL
echo -e "» ${DESC}" && fnewLL
printf "» URL: https://cli.my.id" && fnewLL
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
fnewLL
## End Header ##

function lemp_distro() {
    catdistro

    if test "$CATOS" = 'ubuntu'
    then
        fwget "install_lemp_ubn.sh -O install_lemp_ubn.sh"
        fchmodx "install_lemp_ubn.sh" && ./install_lemp_ubn.sh

    elif test "$CATOS" = 'debian'
    then
        fwget "install_lemp_deb.sh -O install_lemp_deb.sh" 
        fchmodx "install_lemp_deb.sh" && ./install_lemp_deb.sh

    else
        fnewL
        fnosupport
        fbye # Bye message from Cortana
        frmall # remove all downloaded files
    fi
}

function docker_distro() {
    catdistro

    if test "$CATOS" = 'ubuntu'
    then
        fwget "install_docker_ubn.sh -O install_docker_ubn.sh"
        fchmodx "install_docker_ubn.sh" && ./install_docker_ubn.sh

    elif test "$CATOS" = 'debian'
    then
        fwget "install_docker_deb.sh -O install_docker_deb.sh" 
        fchmodx "install_docker_deb.sh" && ./install_docker_deb.sh

    elif test "$CATOSx" = 'centos'
    then
        fwget "install_docker_cent.sh -O install_docker_cent.sh" 
        fchmodx "install_docker_cent.sh" && ./install_docker_cent.sh

    else
        fnewL
        fnosupport
        fbye # Bye message from Cortana
        frmall # remove all downloaded files
    fi
}

echo "Hello, what do you want to do today?"
select yn in "Update my Linux..."\
 "Install LEMP Stack"\
 "Install Docker"\
 "Install Stackdriver Logging & Monitoring"\
 "Install WireGuard VPN (by Nyr)"\
 "Server Benchmark (YABS by masonr)"\
 "Update my Gitea..."\
 "Check IP Whois"\
 "Check RAM Allocation"\
 "Check Website Header"\
 "Try CORTANA... (in Bahasa)"\
 "Nevermind."; do
    case $yn in
        "Update my Linux..." ) 
            FILE01="update.sh"
            fwget "${FILE01} -O ${FILE01}"; # wget from url
            fchmodx "${FILE01}" && ./${FILE01}; # make file executable and execute it
            break;;
        "Install LEMP Stack..." ) 
            lemp_distro;
            break;;
        "Install Docker..." ) 
            docker_distro;
            break;;
        "Install Stackdriver Logging & Monitoring" )
            fnewL;
            echo -e "${LCYAN}»  Installing monitoring agent..${CDEF}";
            sudo curl -sSO https://dl.google.com/cloudagents/install-monitoring-agent.sh;
            sudo bash install-monitoring-agent.sh && sleep 2 && fnewLL;
            echo -e "${LCYAN}»  Installing logging agent..${CDEF}";
            sudo curl -sSO https://dl.google.com/cloudagents/install-logging-agent.sh;
            sudo bash install-logging-agent.sh --structured && fnewLL;
            fdone && fnewLL && sleep 2;
            rm -fR install-logging-agent.sh install-monitoring-agent.sh;
            frmall; # remove all downloaded files
            break;;
        "Install WireGuard VPN (by Nyr)" ) 
            fnewL
            wget https://git.io/wireguard -O wireguard-install.sh && bash wireguard-install.sh; 
            frmall && rm -fR wireguard-install.sh ; # remove all downloaded CLIMYID files
            break;;
        "Server Benchmark (YABS by masonr)" ) 
            fnewL
            curl -s https://raw.githubusercontent.com/masonr/yet-another-bench-script/master/yabs.sh | bash; 
            frmall && rm -fR yabs.sh ; # remove all downloaded CLIMYID files
            break;;
        "Update my Gitea..." ) 
            FILE06="gitea_update.sh"
            fwget "${FILE06} -O ${FILE06}"; # wget from url
            fchmodx "${FILE06}" && ./${FILE06}; # make file executable and execute it
            break;;
        "Check IP Whois" )
            FILE07="ipinfo.sh"
            fwget "${FILE07} -O ${FILE07}"; 
            fchmodx "${FILE07}" && ./${FILE07}; 
            frmfile;
            break;;
        "Check RAM Allocation" ) 
            fnewL;
            ps aux | awk '{print $6/1024 " MB\t\t" $11}' | sort -rn | head -25; 
            frmall; # remove all downloaded files
            break;;
        "Check Website Header" ) 
            fnewL;
            read -rp "Enter URL: " URL;
            fnewL;
            curl -I "${URL}"; 
            frmall; # remove all downloaded files
            break;;
        "Try CORTANA... (in Bahasa)" )
            frmall;
            wget https://cortana.web.app/run.sh && bash run.sh;
            frmfile;  # remove THIS file
            break;;
        "Nevermind." )
            fbye; # bye message
            frmall;
            exit;;
    esac
done