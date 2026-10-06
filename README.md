# fat-relay

ریلی VLESS + WebSocket روی Render (جایگزین عبور از Cloudflare وقتی CF روی خط شما بسته است).

## راه‌اندازی

1. این ریپو را به Render وصل کنید (Dashboard → New → Web Service → Connect this repo).
   - Runtime: Docker (Dockerfile خوانده می‌شود)
   - Plan: Free
2. محیط‌ها (در `render.yaml` هستند، اگر دستی زدید):
   - `UUID` = fb66de89-f31e-483b-99f1-5393bcb4343d
   - `WSPATH` = /fm-ws
   - `PORT` را Render خودش ست می‌کند.
3. بعد از Deploy، دامنه‌ی سرویس (مثل `fat-relay-xxxx.onrender.com`) را بگیرید.

## کانفیگ کلاینت (v2rayNG / هر اپ VLESS)

```
vless://fb66de89-f31e-483b-99f1-5393bcb4343d@<DOMAIN>:443?security=tls&sni=<DOMAIN>&type=ws&host=<DOMAIN>&path=%2Ffm-ws#FatRender
```

`<DOMAIN>` = دامنه‌ی onrender.com سرویس.

## نکات

- پلن رایگان بعد از ~۱۵ دقیقه بی‌کاری می‌خوابد؛ اولین اتصال تا ~۱ دقیقه کند است.
- ترافیک بیش از ۷۵۰ ساعت/ماه = توقف پلن رایگان.
- این سرویس UDP نمی‌دهد؛ فقط HTTP/HTTPS/WebSocket روی ۴۴۳.
