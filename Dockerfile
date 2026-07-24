# استخدام نظام تشغيل Ubuntu خفيف ومستقر
FROM ubuntu:24.04

# منع ظهور أي رسائل تفاعلية أثناء التثبيت
ENV DEBIAN_FRONTEND=noninteractive

# تحديث النظام وتثبيت الأدوات الأساسية، وتليسكيل، وخدمة الـ SSH
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    iptables \
    iproute2 \
    ca-certificates \
    openssh-server \
    && rm -rf /var/lib/apt/lists/*

# إعدادات الـ SSH (السماح بالدخول عبر الجذور وتحديد كلمة المرور Ahmad123)
RUN mkdir /var/run/sshd
RUN echo 'root:Ahmad123' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# تصحيح مسار تسجيل الدخول لـ SSH
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# تثبيت Tailscale تلقائياً
RUN curl -fsSL https://tailscale.com/install.sh | sh

# إنشاء ملف التشغيل لبدء خدمة الـ SSH و Tailscale معاً وإبقاء الحاوية مفتوحة للأبد
RUN echo '#!/bin/sh' > /start.sh && \
    echo '/usr/sbin/sshd' >> /start.sh && \
    echo 'tailscaled --tun=userspace-networking & ' >> /start.sh && \
    echo 'sleep 3' >> /start.sh && \
    echo 'tailscale up --authkey=${TAILSCALE_AUTH_KEY} --hostname=railway-vps' >> /start.sh && \
    echo 'echo "SSH and Tailscale are connected and ready!"' >> /start.sh && \
    echo 'tail -f /dev/null' >> /start.sh && \
    chmod +x /start.sh

# فتح بورت الـ SSH
EXPOSE 22

# أمر التشغيل الأساسي
CMD ["/start.sh"]
