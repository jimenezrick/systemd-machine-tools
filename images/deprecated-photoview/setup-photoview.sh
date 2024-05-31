#!/bin/bash

set -eu

install -d -o photoview -g photoview /home/photoview
usermod --home /home/photoview photoview

ln -s /usr/bin/vendor_perl/exiftool /usr/bin/exiftool

cat >/etc/photoview.env <<EOF
PHOTOVIEW_DATABASE_DRIVER=sqlite
PHOTOVIEW_SQLITE_PATH=/var/lib/photoview/photoview.db
PHOTOVIEW_MEDIA_CACHE=/var/cache/photoview/media_cache

PHOTOVIEW_LISTEN_IP=localhost
PHOTOVIEW_LISTEN_PORT=8000

PHOTOVIEW_SERVE_UI=1
PHOTOVIEW_UI_PATH=/usr/share/webapps/photoview-ui

PHOTOVIEW_DEVELOPMENT_MODE=0
EOF

systemctl enable photoview.service
