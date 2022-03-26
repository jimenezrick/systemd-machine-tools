#!/bin/bash

set -eu

useradd --create-home user
useradd --create-home builder
usermod --append --groups wheel builder

cat >/etc/sudoers.d/wheel-nopasswd <<EOF
%wheel ALL=(ALL) NOPASSWD: ALL
EOF

passwd --delete root
printf 'pts/%d\n' {1..9} >>/etc/securetty
