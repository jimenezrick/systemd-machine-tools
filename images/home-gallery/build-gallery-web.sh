#!/bin/bash

set -eu

VERSION=1.14.3
BIN=home-gallery-${VERSION}-linux-x64
URL=https://dl.home-gallery.org/dist/${VERSION}/${BIN}

if [[ ! -f build/gallery ]]
then
	curl -L $URL -o build/gallery
fi

PHOTOS_PATH=~/photos/2023-12

sudo ../../build-container.sh -r -c gallery-web-rootfs \
     -e '--bind-ro=build:/build' \
     -e "--bind-ro=$PHOTOS_PATH:/photos" \
     -e '--bind=web:/web' \
     -s setup-gallery-web.sh \
     -p perl
