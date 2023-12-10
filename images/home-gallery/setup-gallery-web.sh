#!/bin/bash

set -eu

mkdir -p /home/user/{.config/home-gallery,.cache/home-gallery/storage}

install /build/gallery /usr/bin
install --mode=644 /build/gallery-web.config.yml /home/user/.config/home-gallery/gallery.config.yml
