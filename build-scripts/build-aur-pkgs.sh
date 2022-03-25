#!/bin/bash

set -eu

aur sync --noconfirm --no-view --rmdeps "$@"
