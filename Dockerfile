FROM debian:11

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends ca-certificates build-essential curl && \
    rm -rf /var/lib/apt/lists/*

# su-exec

RUN set -eu && \
    curl -sSL -o /usr/local/bin/su-exec.c https://raw.githubusercontent.com/ncopa/su-exec/master/su-exec.c && \
    gcc -Wall /usr/local/bin/su-exec.c -o/usr/local/bin/su-exec && \
    chown root:root /usr/local/bin/su-exec && \
    chmod 0755 /usr/local/bin/su-exec && \
    rm /usr/local/bin/su-exec.c

# Go

ENV GO_VERSION "1.20.5"

ENV PATH "/usr/local/go/bin:${PATH}"

RUN set -eu && \
    curl -sSL -o go.tar.gz "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz" && \
    tar -C /usr/local -xf go.tar.gz && \
    rm -rf go.tar.gz && \
    go version

# Nodejs

ENV NODE_VERSION "18.16.1"

ENV PATH "/usr/local/node/bin:${PATH}"

RUN set -eu && \
    mkdir -p /usr/local/node && \
    curl -sSL -o node.tar.xz "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz" && \
    tar -C /usr/local/node --strip-components 1 -xf node.tar.xz && \
    rm -rf node.tar.xz && \
    node --version

# JDK

ENV JDK_VERSION "11.0.19"
ENV JDK_VERSION_UPDATE "7"

ENV PATH "/usr/local/jdk/bin:${PATH}"

ENV JAVA_HOME "/usr/local/jdk"
ENV JDK_HOME "/usr/local/jdk"
ENV JRE_HOME "/usr/local/jdk"

RUN set -eu && \
    mkdir -p /usr/local/jdk && \
    curl -sSL -o jdk.tar.gz "https://github.com/adoptium/temurin11-binaries/releases/download/jdk-${JDK_VERSION}%2B${JDK_VERSION_UPDATE}/OpenJDK11U-jdk_x64_linux_hotspot_${JDK_VERSION}_${JDK_VERSION_UPDATE}.tar.gz" && \
    tar -C /usr/local/jdk --strip-components 1 -xf jdk.tar.gz && \
    rm -rf jdk.tar.gz && \
    javac -version

# Entrypoint
ADD docker-entrypoint.sh /docker-entrypoint.sh

WORKDIR /build/workspace

ENTRYPOINT [ "/docker-entrypoint.sh" ]