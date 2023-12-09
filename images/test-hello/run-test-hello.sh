#!/bin/bash

set -eu

sudo systemd-nspawn -D test-hello hello
