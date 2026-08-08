#!/bin/sh
# Download latest DMR ID database from radioid.net
set -e

DEST=/etc/ysf2dmr/DMRIds.dat
TMP=$(mktemp)

curl -sf -o "$TMP" "https://www.radioid.net/static/user.csv"
tail -n +2 "$TMP" | awk -F',' '{print $1 "\t" $2 "\t" $3}' > "${DEST}.tmp"
mv "${DEST}.tmp" "$DEST"
rm -f "$TMP"

echo "Updated DMR IDs: $(wc -l < "$DEST") entries"
