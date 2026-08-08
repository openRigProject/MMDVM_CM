#!/bin/sh
set -e
mkdir -p /var/log/ysf2dmr

# Install daily cron job for DMR ID updates
echo "0 3 * * * root /usr/local/bin/update-dmrids.sh > /dev/null 2>&1" > /etc/cron.d/ysf2dmr-dmrids
chmod 0644 /etc/cron.d/ysf2dmr-dmrids

# Run initial DMR ID download
/usr/local/bin/update-dmrids.sh || true

systemctl daemon-reload
systemctl enable ysf2dmr.service
echo ""
echo "ysf2dmr installed."
echo "  Config: /etc/ysf2dmr/YSF2DMR.ini"
echo "  DMR IDs update daily via /etc/cron.d/ysf2dmr-dmrids"
echo "  Edit the config, then start with: systemctl start ysf2dmr"
echo ""
