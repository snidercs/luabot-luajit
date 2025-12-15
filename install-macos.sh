#!/bin/sh

# This script installs the compiled LuaJIT binaries to /opt/luabot on macOS.
# It deploys both the native macOS universal binaries and the cross-compiled
# roboRIO (linuxathena) binaries from the dist/ directory.

destdir="/opt/luabot"
rm -rf "${destdir}"
mkdir -p "${destdir}/linuxathena"
rsync -var --update dist/osxuniversal/ "${destdir}/"
rsync -var --update dist/linuxathena/ "${destdir}/linuxathena/"
