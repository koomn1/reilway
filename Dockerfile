# استخدام نظام تشغيل Ubuntu خفيف ومستقر
FROM ubuntu:24.04

# منع ظهور أي رسائل تفاعلية أثناء التثبيت
ENV DEBIAN_FRONTEND=noninteractive

# تحديث النظام وتثبيت الأدوات الأساسية وتليسكيل (Tailscale)
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    iptables \
    iproute2 \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# تثبيت Tailscale تلقائياً
RUN curl -fsSL https://tailscale.com/install.sh | sh

# إنشاء ملف تشغيل لبدء Tailscale وإبقاء الحاوية مفتوحة للأبد
RUN echo '#!/bin/sh' > /start.sh && \
    echo 'tailscaled --tun=userspace-networking & ' >> /start.sh && \
    echo 'sleep 3' >> /start.sh && \
    echo 'tailscale up --authkey=${TAILSCALE_AUTH_KEY} --hostname=railway-vps' >> /start.sh && \
    echo 'echo "Tailscale is connected and ready!"' >> /start.sh && \
    echo 'tail -f /dev/null' >> /start.sh && \
    chmod +x /start.sh

# أمر التشغيل الأساسي
CMD ["/start.sh"]