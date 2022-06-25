FROM golang:1.18-alpine as builder

RUN apk add --update python curl which bash git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
