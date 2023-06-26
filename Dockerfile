FROM debian:11

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates build-essential curl && \
    rm -rf /var/lib/apt/lists/*