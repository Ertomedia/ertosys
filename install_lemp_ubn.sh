#!/bin/bash
#
# install_lemp_ubn.sh
# ver 0.1.1
# Modified: 30-06-2020
#
# https://github.com/Ertomedia/ertosys
#
# Copyright (c) 2020 Erol Joudy. Released under the MIT License.

. common.lib

FILE="install_lemp_ubn.sh"

function oscheck() { # OS Check
    fchkdistro

    if [ "$osdebn" = 'ubuntu' ]
    then
        fnewL
        echo -e "${LCYAN}Things that will be installed in this LEMP Stack for Ubuntu.${CDEF}"
        echo -e "[1] NGINX"
        echo -e "[2] Fail2ban"
        echo -e "[3] MySQL"
        echo -e "[4] PHP 7.4"
        #echo -e "[5] Certbot PPA (Let's Encrypt)"
        fnewLL
        echo -e "${LCYAN}Continue?${CDEF}"
        select yn in "YES" "Later"; do
            case $yn in
                YES ) 
                    fnewL && echo -e "${LCYAN}[1]  Installing NGINX...${CDEF}";
                    sudo apt install nginx -y && fnewL;
                    echo -e "${LCYAN}i  Installing NGINX:${CDEF} Configuring firewall.";
                    sudo apt install ufw -y;
                    sudo ufw disable;
                    sudo ufw allow 'OpenSSH';
                    sudo ufw allow 'Nginx Full';
                    sudo ufw enable;
                    echo -e "${LGREN}✔  Installing NGINX:${CDEF} Done.";
                    echo "You may open http://your_server_domain_or_IP in browser." && fnewL;
                    echo -e "${LCYAN}[2]  Installing Fail2ban...${CDEF}";
                    sudo apt install fail2ban -y;
                    sudo service fail2ban start;
                    echo -e "${LGREN}✔  Installing Fail2ban:${CDEF} Done." && fnewL;
                    echo -e "${LCYAN}[3]  Installing MySQL...${CDEF}";
                    sudo apt install mysql-server -y && fnewL;
                    echo -e "${LCYAN}i  Installing MySQL:${CDEF} Securing installation.";
                    sudo mysql_secure_installation;
                    echo -e "${LGREN}✔  Installing MySQL:${CDEF} Done." && fnewL;
                    echo -e "${LCYAN}[4]  Installing PHP 7.4...${CDEF}";
                    sudo apt install software-properties-common -y;
                    sudo add-apt-repository ppa:ondrej/php;
                    sudo add-apt-repository ppa:ondrej/nginx;
                    sudo apt update -y;
                    sudo apt install php7.4-{fpm,common,mysql,xml,xmlrpc,curl,gd,imagick,cli,dev,imap,mbstring,opcache,soap,zip} unzip -y;
                    echo -e "${LGREN}✔  Installing PHP 7.4:${CDEF} Done." && fnewL;
                    # echo -e "${LCYAN}[5]  Installing Certbot PPA...${CDEF}";
                    # sudo add-apt-repository universe;
                    # sudo add-apt-repository ppa:certbot/certbot;
                    # sudo apt-get update -y;
                    # sudo apt-get install certbot python-certbot-nginx -y;
                    # sudo certbot --nginx;
                    # echo -e "${LCYAN}i  Installing Certbot PPA:${CDEF} Testing automatic renewal.";
                    # sudo certbot renew --dry-run;
                    # echo -e "${LGREN}✔  Installing Certbot PPA:${CDEF} Done.";
                    # echo "To confirm that your site is set up properly, visit https://yourwebsite.com/ in your browser and look for the lock icon in the URL bar." && fnewL;
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

                    fi && sleep 1;
                    # Check MySQL status
                    SQL=$(sudo service mysql status | grep 'Active' | awk '{print $3}');
                    if test "$SQL" = "(running)"
                    then
                        echo -e "${LGREN}✔  MySQL is running.${CDEF}" && ERRS=0

                    else
                        echo -e "${LRED}×  MySQL is not running.${CDEF}" && ERRS=1

                    fi && sleep 1;
                    # Check PHP status
                    PHP=$(sudo service php7.4-fpm status | grep 'Active' | awk '{print $3}');
                    if test "$PHP" = "(running)"
                    then
                        echo -e "${LGREN}✔  php7.4-fpm is running.${CDEF}" && ERRP=0

                    else
                        echo -e "${LRED}×  php7.4-fpm is not running.${CDEF}" && ERRP=1

                    fi && fnewL;
                    # Status report
                    (( RPT = ERRN + ERRF + ERRS + ERRP ));
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