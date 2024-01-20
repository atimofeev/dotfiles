#!/usr/bin/env bash
docker run --rm -i koalaman/shellcheck:stable "$@" <&0
