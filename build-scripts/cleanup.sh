#!/bin/bash

set -eu

rm -rv /home/builder/*
rm -rv /build-scripts/

pacman -Rs --noconfirm devtools gcc
pacman -Scc --noconfirm
