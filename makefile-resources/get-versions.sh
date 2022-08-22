#!/bin/bash

case $TYPE in
    current_debian_version)
        curl -s https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/ | grep -oE "debian-(.*)-amd64-netinst.iso" | sed -e 's/<[^>]*>//g' | cut -d">" -f 1 | sed 's/"//g' | head -n 1 | cut -d- -f2
    ;;
    checkifbuild)
        if [ "$CURRENT_KUBERNETES_VERSION" = "$CURRENT_BOX_VERSION" ]; then
            echo "false"
        else
            echo "true"
        fi
    ;;
esac

exit 0