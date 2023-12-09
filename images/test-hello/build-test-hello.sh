#!/bin/bash

set -eu

sudo ../build-container.sh -r -c test-hello -s setup-test-hello.sh \
     -p curl
