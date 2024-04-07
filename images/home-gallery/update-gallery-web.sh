#!/bin/bash

set -eu

PHOTOS_PATH=~/stuff

sudo systemd-nspawn -D gallery-web-rootfs --user user \
     --bind-ro="$PHOTOS_PATH:/photos" \
     gallery run import --update

sudo systemd-nspawn -D gallery-web-rootfs --user user \
     --bind=web:/web \
     gallery export static -d /home/user/.config/home-gallery/database.db -s /home/user/.cache/home-gallery/storage -o /web/gallery
