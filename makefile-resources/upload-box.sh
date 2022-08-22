#!/bin/bash

if [[ "$PROVIDER" == *"vmware"* ]];
then
    HyperVisor="vmware_desktop"
else
    HyperVisor=$PROVIDER
fi

export DATETIME=$(date "+%Y-%m-%d %H:%M:%S")

BOXFILE=$(cat /tmp/packer-build/$CURRENT_VERSION/manifest.json | jq '.builds | .[].files | .[].name' | grep "$CURRENT_VERSION" | grep "$PROVIDER" | sed 's/"//g' | uniq)

echo "Box $BOXFILE found, uploading..." 
vagrant cloud version create $VAGRANT_CLOUD_REPOSITORY_BOX_NAME $CURRENT_VERSION || true
vagrant cloud version update -d "$(cat ./makefile-resources/uploading-box-notification-template.md | envsubst)" $VAGRANT_CLOUD_REPOSITORY_BOX_NAME $CURRENT_VERSION
vagrant cloud provider delete -f $VAGRANT_CLOUD_REPOSITORY_BOX_NAME $HyperVisor $CURRENT_VERSION || true
SHASUM=$(shasum $BOXFILE | awk '{ print $1 }')
vagrant cloud provider create --timestamp --checksum-type sha1 --checksum $SHASUM $VAGRANT_CLOUD_REPOSITORY_BOX_NAME $HyperVisor $CURRENT_VERSION
vagrant cloud provider upload $VAGRANT_CLOUD_REPOSITORY_BOX_NAME $HyperVisor $CURRENT_VERSION $BOXFILE
vagrant cloud version update -d "$(cat ./makefile-resources/box-version-description-template.md | envsubst)" $VAGRANT_CLOUD_REPOSITORY_BOX_NAME $CURRENT_VERSION
vagrant cloud version release -f $VAGRANT_CLOUD_REPOSITORY_BOX_NAME $CURRENT_VERSION || true
echo "Box $BOXFILE uploaded"