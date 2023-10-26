#!/bin/bash
arg_count="$#"
if [ "$arg_count" -eq 1 ]; then
    path="$1"
    filename=$(basename "$1")
    docker run --rm -i -v $path:/workdir/$filename ghcr.io/igorshubovych/markdownlint-cli:latest $filename
elif [ "$arg_count" -eq 3 ] && [ "$1" == "--config" ]; then
    path="$3"
    filename=$(basename "$3")
    confpath="$2"
    docker run --rm -i -v $path:/workdir/$filename -v $confpath:/conf.yml ghcr.io/igorshubovych/markdownlint-cli:latest --config /conf.yml $filename
fi
