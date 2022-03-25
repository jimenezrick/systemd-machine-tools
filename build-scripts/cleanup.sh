#!/bin/bash

set -eu

rm -rv /home/builder/*
rm -rv /build-scripts/

pacman -Rs --noconfirm devtools gcc
pacman -Scc --noconfirm

rm -r /usr/share/{locale,man,doc}
