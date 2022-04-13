FROM golang:alpine3.11 as builder

RUN apk add --update python curl which bash git \
    && wget -q https://get.helm.sh/helm-v3.8.1-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
