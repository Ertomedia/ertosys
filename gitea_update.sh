#!/bin/bash
. common.lib

FILE="gitea_update.sh"

function gitea_update() { # Updating Gitea

    if test -f /etc/systemd/system/gitea.service
    then
        echo "» Stopping Gitea..." && fnewL
        sudo systemctl stop gitea && sleep 1
        echo "Please enter the new version of Gitea. Check here for info, https://dl.gitea.io/gitea/" && fnewL
        read -r VERSION
        echo "» Downloading new version of Gitea..." && fnewL
        wget -O /tmp/gitea https://dl.gitea.io/gitea/"${VERSION}"/gitea-"${VERSION}"-linux-amd64 && sleep 1
        echo "» Installing new version of Gitea..." && fnewL
        sudo mv /tmp/gitea /usr/local/bin && sleep 1
        fchmodx "/usr/local/bin/gitea" && sleep 1
        sudo systemctl restart gitea
        fdone # finished operation message
        frmall # remove all downloaded CLIMYID files

    else
        fnewL
        echo "» Unable to locate Gitea in systemd, maybe did not installed properly. Perhaps using Docker?"
        echo "» Exiting now."
        frmall
    fi
}
fnewL
echo "» Checking Gitea..." && fnewL
gitea_update