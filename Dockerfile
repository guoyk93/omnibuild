FROM debian:11

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates build-essential curl && \
    rm -rf /var/lib/apt/lists/*

# Go

ENV GO_VERSION "1.20.5"

RUN curl -sSL -o go.tar.gz "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz" && \
    tar -C /usr/local -xf go.tar.gz && \
    rm -rf go.tar.gz

ENV PATH "/usr/local/go/bin:${PATH}"

# Nodejs

ENV NODE_VERSION "18.16.1"

RUN mkdir -p /usr/local/node && \
    curl -sSL -o node.tar.xz "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz" && \
    tar -C /usr/local/node --strip-components 1 -xf node.tar.xz && \
    rm -rf node.tar.xz

ENV PATH "/usr/local/node/bin:${PATH}"