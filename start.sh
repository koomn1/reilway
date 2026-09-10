#!/bin/bash

if [ -f "/app/cookies.json" ]; then
    echo "✅ Using cookies.json for authentication"
    web2api serve --host 0.0.0.0 --port $PORT --cookies /app/cookies.json
else
    echo "⚠️ No cookies.json found. Running in normal mode (may need manual login)."
    web2api serve --host 0.0.0.0 --port $PORT
fi
