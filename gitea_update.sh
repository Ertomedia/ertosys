#!/bin/bash
#
# gitea_update.sh
# ver 0.1.1
# Modified: 30-06-2020
#
# https://github.com/Ertomedia/ertosys
#
# Copyright (c) 2020 Erol Joudy. Released under the MIT License.

. common.lib

FILE="gitea_update.sh"

gitea_update() { # Updating Gitea

    if [ -f /etc/systemd/system/gitea.service ]
    then
        echo "i  Stopping Gitea..." && fnewL
        sudo systemctl stop gitea && sleep 1
        echo "»  Please enter the new version of Gitea. Check here for info, https://dl.gitea.io/gitea/" && fnewL
        read -r VERSION
        echo "i  Downloading new version of Gitea..." && fnewL
        wget -O /tmp/gitea https://dl.gitea.io/gitea/"${VERSION}"/gitea-"${VERSION}"-linux-amd64 && sleep 1
        echo "i  Installing new version of Gitea..." && fnewL
        sudo mv /tmp/gitea /usr/local/bin && sleep 1
        fchmodx "/usr/local/bin/gitea" && sleep 1
        sudo systemctl restart gitea
        fdone # finished operation message
        frmall # remove all downloaded CLIMYID files

    else
        fnewL
        echo "i  Unable to locate Gitea in systemd, maybe did not installed properly. Perhaps using Docker?"
        echo "i  Exiting now."
        frmall
    fi
}
fnewL
echo "i  Checking Gitea..." && fnewL
gitea_update