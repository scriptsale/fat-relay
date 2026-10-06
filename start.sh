#!/bin/sh
set -eu

PORT="${PORT:-10000}"
UUID="${UUID:-fb66de89-f31e-483b-99f1-5393bcb4343d}"
WSPATH="${WSPATH:-/fm-ws}"

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
