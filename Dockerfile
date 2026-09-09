# استخدم الصورة الرسمية للمشروع أو قم ببنائها من المصدر
FROM acheong08/chatgpt-to-api:latest

# أو يمكنك بناء الصورة من الكود المصدري:
# FROM golang:alpine AS builder
# WORKDIR /app
# COPY go.mod go.sum ./
# RUN go mod download
# COPY . .
# RUN go build -o freechatgpt .
# 
# FROM alpine
# WORKDIR /app
# COPY --from=builder /app/freechatgpt .
# EXPOSE 8080
# CMD ["./freechatgpt"]

# في حالة استخدام الصورة الجاهزة، الأمر التالي كافٍ:
CMD ["./freechatgpt"]
