#!/bin/bash

set -eu

if [[ -n "$*" ]]
then
	paru -S "$@"
fi
