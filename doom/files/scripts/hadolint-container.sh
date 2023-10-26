#!/bin/bash
docker run --rm -i hadolint/hadolint hadolint --no-color /dev/stdin <&0
