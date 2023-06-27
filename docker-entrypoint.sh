#!/bin/bash

set -eu

# this script must started from root user
if [ "0" != "$(id -u)" ]; then
    echo "This script must be run as root"
    exit 1
fi

# add user and group, this allows root and non-root, and also allows duplicated ids
groupadd -g "${HOST_GID}" -o omnibuild-group
useradd -u "${HOST_UID}" -G omnibuild-group -o -M -d /build/home omnibuild-user

exec su-exec "omnibuild-user:omnibuild-group" "$@"
