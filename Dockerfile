FROM python:3.12-slim

# تثبيت المتطلبات الأساسية و Chrome
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# تثبيت Google Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/google-chrome.gpg \
    && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update && apt-get install -y google-chrome-stable

WORKDIR /app

# نسخ ملف المتطلبات
COPY requirements.txt .

# تثبيت الحزم المطلوبة
RUN pip install --no-cache-dir -r requirements.txt

# نسخ سكربت التشغيل
COPY start.sh .
RUN chmod +x start.sh

# تحديد المنفذ
EXPOSE $PORT

# أمر التشغيل
CMD ["bash", "start.sh"]
