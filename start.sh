#!/bin/sh
set -eu

PORT="${PORT:-10000}"
WSPATH="${WSPATH:-/fm-ws}"

if [ -z "${UUID:-}" ]; then
  echo "ERROR: UUID env var is required" >&2
  exit 1
fi

cat > /tmp/config.json <<EOF
{
  "log": { "loglevel": "warning" },
  "inbounds": [
    {
      "listen": "0.0.0.0",
      "port": ${PORT},
      "protocol": "vless",
      "settings": {
        "clients": [ { "id": "${UUID}" } ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": { "path": "${WSPATH}" }
      }
    }
  ],
  "outbounds": [
    { "protocol": "freedom", "tag": "direct" },
    { "protocol": "blackhole", "tag": "block" }
  ]
}
EOF

echo "starting xray vless-ws on :${PORT} path ${WSPATH}"
exec /opt/xray/xray run -c /tmp/config.json
