#!/bin/bash

set -eu

exec su-exec "${EUID}:${EGID}" "$@"