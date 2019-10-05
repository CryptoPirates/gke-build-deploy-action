FROM alpine as base

RUN apk add --update python curl which bash git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
