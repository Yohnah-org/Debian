export CURRENT_DEBIAN_VERSION := $(shell TYPE=current_debian_version sh ./makefile-resources/get-versions.sh)
export CURRENT_VERSION := $(CURRENT_DEBIAN_VERSION)
export OUTPUT_DIRECTORY := /tmp
export PACKER_DIRECTORY_OUTPUT := $(OUTPUT_DIRECTORY)/packer-build
export DATETIME := $(shell date "+%Y-%m-%d %H:%M:%S")
export PROVIDER := virtualbox
export MANIFESTFILE := $(PACKER_DIRECTORY_OUTPUT)/$(CURRENT_DEBIAN_VERSION)/manifest.json
export UPLOADER_DIRECTORY := $(PACKER_DIRECTORY_OUTPUT)/toupload
export VAGRANT_CLOUD_REPOSITORY_BOX_NAME := Yohnah/Debian
export BOX_NAME=Debian

.PHONY: all versions checkifbuild

all: version build test

versions: 
	@echo "========================="
	@echo Current Debian Version: $(CURRENT_DEBIAN_VERSION)
	@echo Provider: $(PROVIDER)
	@echo "========================="
	@echo ::set-output name=debianversion::$(CURRENT_DEBIAN_VERSION)

requirements:
	mkdir -p $(PACKER_DIRECTORY_OUTPUT)/$(CURRENT_VERSION)/$(PROVIDER)
	mkdir -p $(PACKER_DIRECTORY_OUTPUT)/toupload
	mkdir -p $(PACKER_DIRECTORY_OUTPUT)/test/$(CURRENT_VERSION)/$(PROVIDER)

build: requirements
	sh ./makefile-resources/build-box.sh
	@echo ::set-output name=manifestfile::$(MANIFESTFILE)

add_box:
	sh ./makefile-resources/add-box.sh

del_box:
	sh ./makefile-resources/del-box.sh

upload:
	sh ./makefile-resources/upload-box.sh

clean:
	rm -fr $(PACKER_DIRECTORY_OUTPUT) || true