#!/bin/bash

# التأكد من وجود ملف الكوكيز
if [ -f "/app/cookies.json" ]; then
    echo "✅ Using cookies.json for authentication"
    web2api serve --port $PORT --cookies /app/cookies.json
else
    echo "⚠️ No cookies.json found. Running in normal mode (may need manual login)."
    web2api serve --port $PORT
fi
