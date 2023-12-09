#!/bin/bash

set -eu

mkdir -p /tmp/test
cat >/tmp/test/hello <<EOF
#!/bin/bash

echo 'Hello world!'
EOF

sudo ../../build-container.sh -r -c test-hello-rootfs -e '--bind-ro=/tmp/test:/tmp/test' -s setup-test-hello.sh \
     -p curl
