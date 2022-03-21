#!/bin/bash

set -eu

git clone https://aur.archlinux.org/aura-bin.git
cd aura-bin
makepkg -i --noconfirm
