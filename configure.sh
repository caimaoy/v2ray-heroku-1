#!/bin/bash
# Install V2Ray
curl -H "Cache-Control: no-cache" -o /tmp/v2ray.zip https://github.com/v2ray/v2ray-core/releases/download/v${V2VER}/v2ray-linux-64.zip
mkdir -p /etc/v2ray /var/log/v2ray /usr/bin/v2ray
unzip /tmp/v2ray.zip v2ray v2ctl -d /usr/bin/v2ray
rm /tmp/v2ray.zip
chmod +x /usr/bin/v2ray/v2ray /usr/bin/v2ray/v2ctl
# V2Ray new configuration
cat <<-EOF > /etc/v2ray/config.json
{
  "inbounds": [
  {
    "port": ${PORT},
    "protocol": "vmess",
    "settings": {
      "clients": [
        {
          "id": "${UUID}",
          "alterId": 64
        }
      ]
    },
    "streamSettings": {
      "network": "ws"
    }
  }
  ],
  "outbounds": [
  {
    "protocol": "freedom",
    "settings": {}
  }
  ],
  "dns": {
      "servers": [
          "https+local://1.1.1.1/dns-query",
          "1.1.1.1",
          "223.5.5.5",
          "8.8.8.8",
          "119.29.29.29",
          "localhost"
      ]
  }
}
EOF
/usr/bin/v2ray/v2ray -config=/etc/v2ray/config.json
