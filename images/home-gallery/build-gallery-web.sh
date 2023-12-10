#!/bin/bash

set -eu

VERSION=1.14.2
BIN=home-gallery-${VERSION}-linux-x64
URL=https://dl.home-gallery.org/dist/${VERSION}/${BIN}

if [[ ! -f build/gallery ]]
then
	curl -L $URL -o build/gallery
fi

sudo ../../build-container.sh -r -c gallery-web-rootfs \
     -e '--bind-ro=build:/build' \
     -s setup-gallery-web.sh
