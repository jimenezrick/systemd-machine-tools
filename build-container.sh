#!/bin/bash

set -eu

BASE_PKGS=(base base-devel git)
CONTAINER=$1
shift

mkdir -p $CONTAINER
pacstrap -c $CONTAINER ${BASE_PKGS[@]}

cp -rv build-scripts/ $CONTAINER/
systemd-nspawn -D $CONTAINER /build-scripts/add-users.sh
systemd-nspawn -D $CONTAINER --chdir /home/builder -u builder \
	       /build-scripts/install-aur-helper.sh
rm -rv $CONTAINER/build-scripts/

systemd-nspawn -D $CONTAINER --chdir /home/builder -u builder \
	       sudo aura --aursync --clean --quiet --noconfirm $@
