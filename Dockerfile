FROM alpine:3.20

RUN apk add --no-cache ca-certificates curl unzip \
 && curl -fsSL -o /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip \
 && mkdir -p /opt/xray \
 && unzip -o /tmp/xray.zip -d /opt/xray \
 && chmod +x /opt/xray/xray \
 && rm -f /tmp/xray.zip \
 && apk del curl unzip

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 10000
ENTRYPOINT ["/start.sh"]
