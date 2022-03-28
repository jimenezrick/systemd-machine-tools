#!/bin/bash

set -eu

sudo ../build-container.sh -c photoview -s setup-photoview.sh \
     -a photoview \
     -p sqlite \
     -p ffmpeg \
     -p darktable \
     -p perl-image-exiftool
