#!/bin/bash

set -eu

rm -rv /build-scripts/

pacman -Scc --noconfirm
