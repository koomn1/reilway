FROM node:20-alpine

# تثبيت المتطلبات + git
RUN apk add --no-cache \
    git \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont

# تعيين متغيرات Puppeteer
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

WORKDIR /app

# استنساخ المشروع
RUN git clone https://github.com/leiurayer/chat2api.git .

# تثبيت المكتبات
RUN npm install

# تعيين المنفذ
EXPOSE 8080

# أمر التشغيل
CMD ["node", "index.js"]
