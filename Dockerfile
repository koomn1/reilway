FROM golang:alpine AS builder

RUN apk add --no-cache git

WORKDIR /app

RUN git clone https://github.com/xqdoo00o/ChatGPT-to-API.git .

RUN go mod download
RUN go build -o chatgpt-to-api .

FROM alpine:latest

RUN apk add --no-cache ca-certificates

WORKDIR /app

COPY --from=builder /app/chatgpt-to-api .

EXPOSE 8080

CMD ["./chatgpt-to-api"]
