#!/bin/bash

set -eu

cat >/etc/pacman.d/mirrorlist <<EOF
## UK
Server = https://lon.mirror.rackspace.com/archlinux/\$repo/os/\$arch
Server = https://mirror.bytemark.co.uk/archlinux/\$repo/os/\$arch
Server = https://mirror.cov.ukservers.com/archlinux/\$repo/os/\$arch
EOF

pacman -Sy
pacman-key --init
pacman-key --populate
