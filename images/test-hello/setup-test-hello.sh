#!/bin/bash

set -eu

cat >/bin/hello <<EOF
#!/bin/bash

echo 'Hello world!'
EOF

chmod 755 /bin/hello
