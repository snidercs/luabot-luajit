#!/bin/sh

# This script builds LuaJIT for roboRIO using Docker and extracts the compiled artifacts.
# It creates a Docker image with the cross-compilation toolchain, builds LuaJIT inside
# the container, then copies the resulting binaries to the local dist/ directory.

set -e
docker build . -t snidercs/luabot
docker create --name luajit_temp snidercs/luabot

mkdir -p dist
rm -rf dist/linuxathena

docker cp luajit_temp:/opt/luabot/linuxathena ./dist/linuxathena
docker rm luajit_temp

exit 0
