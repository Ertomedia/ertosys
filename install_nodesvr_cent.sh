#!/bin/bash
#
# install_nodesvr_cent.sh
# ver 0.1.0
# Modified: 12-06-2020

. common.lib

FILE="install_nodesvr_cent.sh"

function oscheck() { # OS Check
    catdistro

    if test "$CATOSx" = 'centos'
    then
        fnewL
        echo -e "${LCYAN}Things that will be installed in this NodeJS server Stack for CentOS.${CDEF}"
        echo -e "[1] Node.js + NPM"
        echo -e "[2] NGINX"
        # echo -e "[3] Fail2ban"
        fnewLL
        echo -e "${LCYAN}Continue?${CDEF}"
        select yn in "YES" "Later"; do
            case $yn in
                YES ) 
                    TOPIC="Installing Node.js + NPM";
                    fnewL && echo -e "${LCYAN}[1]  ${TOPIC}...${CDEF}";
                    echo -e "${LCYAN}»  Node version to install? ( 12 / 13 / 14 )${CDEF} " && read -r NODEJS;
                    sudo curl --silent --location https://rpm.nodesource.com/setup_"${NODEJS}".x | sudo bash - && fnewL;
                    echo -e "${LCYAN}»  Please specify Node.js port? (ex: 3000)${CDEF} " && read -r NODEPORT && fnewL;
                    echo -e "${LCYAN}i  ${TOPIC}:${CDEF} Installing...";
                    sudo yum install -y nodejs;
                    echo -e "${LCYAN}i  ${TOPIC}:${CDEF} Verifying Node...";
                    node --version && fnewL;
                    echo -e "${LCYAN}i  ${TOPIC}:${CDEF} Verifying NPM...";
                    npm --version && fnewL;
                    echo -e "${LGREN}✔  ${TOPIC}:${CDEF} Done." && fnewLL;
                    TOPIC="Installing NGINX";
                    fnewL && echo -e "${LCYAN}[2]  ${TOPIC}...${CDEF}";
                    sudo yum install -y nginx && fnewL;
                    # echo -e "${LCYAN}i  ${TOPIC}:${CDEF} Configuring firewall.";
                    # sudo apt install ufw -y;
                    # sudo ufw disable;
                    # sudo ufw allow 'OpenSSH';
                    # sudo ufw allow 'Nginx Full';
                    # sudo ufw allow "${NODEPORT}";
                    # sudo ufw enable;
                    echo -e "${LCYAN}i  ${TOPIC}:${CDEF} Configuring NGINX.";
                    sudo rm /etc/nginx/sites-available/default;
                    sudo rm /etc/nginx/sites-enabled/default && fnewL;
                    echo -e "${LCYAN}»  Please input FQDN for this stack? (ex: nodeserver.yourdomain.com)${CDEF} " && read -r DOMAIN;
                    echo "
server {
    listen [::]:80;
    listen 80;

    server_name ${DOMAIN};

location / {
    proxy_pass http://localhost:${NODEPORT};
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header Host $host;
    proxy_cache_bypass $http_upgrade;
}" | sudo tee -a /etc/nginx/sites-available/"${DOMAIN}";
                    sudo ln -s /etc/nginx/sites-available/"${DOMAIN}" /etc/nginx/sites-enabled/"${DOMAIN}";
                    sudo nginx -t && sudo service nginx restart;
                    echo -e "${LGREN}✔  ${TOPIC}:${CDEF} Done.";
                    echo "Domain http://${DOMAIN} can now be accessed from browser." && fnewLL;
                    TOPIC="Installing Fail2ban"
                    echo -e "${LCYAN}[2]  ${TOPIC}...${CDEF}";
                    sudo yum install -y fail2ban;
                    sudo service fail2ban start;
                    echo -e "${LGREN}✔  ${TOPIC}:${CDEF} Done." && fnewLL;
                    echo -e "${LCYAN}i  Finalizing:${CDEF} Getting service status.";
                    # Check NGINX status
                    NGINX=$(sudo service nginx status | grep 'Active' | awk '{print $3}');
                    if test "$NGINX" = "(running)"
                    then
                        echo -e "${LGREN}✔  NGINX is running.${CDEF}" && ERRN=0

                    else
                        echo -e "${LRED}×  NGINX is not running.${CDEF}" && ERRN=1

                    fi && sleep 1;
                    # Check Fail2ban status
                    F2B=$(sudo service fail2ban status | grep 'Active' | awk '{print $3}');
                    if test "$F2B" = "(running)"
                    then
                        echo -e "${LGREN}✔  Fail2ban is running.${CDEF}" && ERRF=0

                    else
                        echo -e "${LRED}×  Fail2ban is not running.${CDEF}" && ERRF=1

                    fi && fnewL;
                    # Status report
                    (( RPT = ERRN + ERRF ));
                    if test "$RPT" == 0
                    then
                        fdone && fnewL
                    else
                        echo -e "${LCYAN}i  Please troubleshoot manually all errors.${CDEF}"
                    fi && sleep 1 && fnewL;
                    frmall; # remove all downloaded files
                    break;;
                Later )
                    fbye; # Bye message from Cortana
                    frmall; # remove all downloaded files
                    exit;;
            esac
        done

    else
        fnewL
        fnosupport
        fbye # Bye message from Cortana
        frmall # remove all downloaded files
    fi
}

oscheck