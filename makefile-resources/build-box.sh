#!/bin/bash -x

echo "Init packer build for debian $CURRENT_DEBIAN_VERSION version and $PROVIDER as provider"
cd packer; packer build -var "debian_version=$CURRENT_DEBIAN_VERSION" -var "vm_name=$BOX_NAME" -var "output_directory=$PACKER_DIRECTORY_OUTPUT" -only builder.$PROVIDER-iso.debian packer.pkr.hcl