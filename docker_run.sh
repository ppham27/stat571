#!/usr/bin/env bash

docker run -p 8888:8888 -p 6006:6006 \
       -u $(id -u):$(id -g) \
       -it --rm \
       -v "$(pwd):/tf/local" \
       stat571:latest \
       "$@"
