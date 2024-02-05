#!/bin/bash

set -eu

VERSION=1.15.0
BIN=home-gallery-${VERSION}-linux-x64
URL=https://dl.home-gallery.org/dist/${VERSION}/${BIN}

if [[ ! -f build/gallery ]]
then
	curl -L $URL -o build/gallery
fi

PHOTOS_PATH=~/stuff

sudo ../../build-container.sh -r -c gallery-web-rootfs \
     -e '--bind-ro=build:/build' \
     -e "--bind-ro=$PHOTOS_PATH:/photos" \
     -e '--bind=web:/web' \
     -s setup-gallery-web.sh \
     -p perl
