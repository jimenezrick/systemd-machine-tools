#!/bin/bash

set -eu

git clone https://aur.archlinux.org/aurutils.git
cd aurutils && makepkg -s -r -i --noconfirm

sudo tee -a /etc/pacman.conf <<EOF

[custom]
SigLevel = Optional TrustAll
Server = file:///home/builder/custompkgs
EOF

mkdir /home/builder/custompkgs
repo-add /home/builder/custompkgs/custom.db.tar.gz
sudo pacman -Sy
