FROM golang:alpine3.11 as builder

RUN apk add --update python curl which bash git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
