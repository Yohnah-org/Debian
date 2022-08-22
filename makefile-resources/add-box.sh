#!/bin/bash -x
BOXFILE=$(cat /tmp/packer-build/$CURRENT_VERSION/manifest.json | jq '.builds[].files[].name' | sed 's/"//g' | tail -n 1)
vagrant box add --provider $PROVIDER -f --name $VAGRANT_CLOUD_REPOSITORY_BOX_NAME-test $BOXFILE