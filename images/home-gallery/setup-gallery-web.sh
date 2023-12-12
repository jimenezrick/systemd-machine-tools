#!/bin/bash

set -eu

install /build/gallery /usr/bin
install --directory --owner=user --group=user /home/user/{.config/home-gallery,.cache/home-gallery/storage}
install --mode=644 --owner=user --group=user /build/gallery.config.yml /home/user/.config/home-gallery/gallery.config.yml

sudo -u user gallery run import
sudo -u user -i gallery export static -d .config/home-gallery/database.db -s .cache/home-gallery/storage -f /web/gallery.tar.gz

# For debugging:
#bash
