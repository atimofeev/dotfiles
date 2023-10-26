#!/bin/bash
path=${!#}
dir_name=$(dirname "$path")
docker run --rm -i -v "$dir_name":/data ghcr.io/terraform-linters/tflint --format=json
