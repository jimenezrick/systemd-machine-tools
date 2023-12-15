#!/bin/bash

set -eu

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
REMOTE=root@vpn.in.untroubled.be:/var/www

rsync --archive --delete --info=flist2,progress2 $SCRIPT_DIR/gallery/ $REMOTE
