#!/bin/bash

set -eu

(sudo systemd-nspawn -D test-hello-rootfs hello | grep 'Hello world!' && echo ok) || echo failed
