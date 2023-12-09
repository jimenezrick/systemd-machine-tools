#!/bin/bash

set -eu

VERSION=v2.0.1
TARBALL=paru-${VERSION}-x86_64.tar.zst
URL=https://github.com/Morganamilo/paru/releases/download/${VERSION}/${TARBALL}

mkdir /tmp/paru
wget --directory-prefix=/tmp/paru $URL
tar xf /tmp/paru/$TARBALL --directory /tmp/paru

install --mode=644 /tmp/paru/paru.conf /etc
install /tmp/paru/paru /usr/bin
