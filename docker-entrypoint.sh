#!/bin/bash

if [ -z "${EUID}" ] || [ -z "${EGID}" ]; then
    echo "ERROR: \$EUID or \$EGID is not set"
    exit 1
fi

set -eu

if [ "0" = "${EUID}" ] || [ "0" = "${EGID}" ]; then
    echo "ERROR: This script must be run as a non-root user"
    exit 1
fi

if [ "${EUID}" = "${EGID}" ]; then
    useradd -u "${EUID}" -d /build/home omnibuild
else
    groupadd -f -g "${EGID}" omnibuild-group
    useradd -u "${EUID}" -G "${EGID}" -d /build/home omnibuild
fi

exec su-exec "${EUID}:${EGID}" "$@"
