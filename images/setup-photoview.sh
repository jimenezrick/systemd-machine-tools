#!/bin/bash

set -eu

cat >/etc/photoview.env <<EOF
PHOTOVIEW_DATABASE_DRIVER=sqlite
PHOTOVIEW_SQLITE_PATH=/var/lib/photoview/photoview.db

PHOTOVIEW_LISTEN_IP=localhost
PHOTOVIEW_LISTEN_PORT=8000

PHOTOVIEW_SERVE_UI=1
PHOTOVIEW_DEVELOPMENT_MODE=0
EOF

systemctl enable photoview.service
