#!/bin/sh

# This script builds LuaJIT for macOS and roboRIO platforms.
# It compiles LuaJIT separately for x86_64 and ARM64 architectures, then combines
# them into a universal binary using lipo. After creating the macOS universal binary,
# it invokes the Docker build to cross-compile LuaJIT for the roboRIO platform.
# All build artifacts are placed in the dist/ directory.

export MACOSX_DEPLOYMENT_TARGET=10.15

wpilib_year="2025"

distdir="`pwd`/dist"
mkdir -p "$distdir"
rm -rf "$distdir"/*

set -e

cd luajit
arch -x86_64 make amalg \
    XCFLAGS="-DLUAJIT_ENABLE_LUA52COMPAT=1" \
    BUILDMODE="static" \
    PREFIX="/opt/luabot"
make install PREFIX="$distdir/x86_64"
make clean

arch -arm64 make amalg \
    XCFLAGS="-DLUAJIT_ENABLE_LUA52COMPAT=1" \
    BUILDMODE="static" \
    PREFIX="/opt/luabot"
make install PREFIX="$distdir/arm64"
make clean
cd ..

# Create universal binary
mkdir -p "$distdir/osxuniversal/bin"
mkdir -p "$distdir/osxuniversal/lib"
mkdir -p "$distdir/osxuniversal/include"

# Get the real binary names from symlinks
x86_64_bin=$(ls -L "$distdir/x86_64/bin/" | grep -v "^luajit$" | head -1)
arm64_bin=$(ls -L "$distdir/arm64/bin/" | grep -v "^luajit$" | head -1)

lipo -create "$distdir/x86_64/bin/$x86_64_bin" "$distdir/arm64/bin/$arm64_bin" \
    -output "$distdir/osxuniversal/bin/luajit"

lipo -create "$distdir/x86_64/lib/libluajit-5.1.a" "$distdir/arm64/lib/libluajit-5.1.a" \
    -output "$distdir/osxuniversal/lib/libluajit-5.1.a"

cp -r "$distdir/arm64/include"/* "$distdir/osxuniversal/include/"
cp -r "$distdir/arm64/share" "$distdir/osxuniversal/"

# Copy and update pkg-config file
mkdir -p "$distdir/osxuniversal/lib/pkgconfig"
cp "$distdir/arm64/lib/pkgconfig/luajit.pc" "$distdir/osxuniversal/lib/pkgconfig/luajit.pc"
sed -i '' 's|^prefix=.*|prefix=/opt/luabot|' "$distdir/osxuniversal/lib/pkgconfig/luajit.pc"

rm -rf dist/arm64 dist/x86_64

sh build-roborio-docker.sh

exit 0
