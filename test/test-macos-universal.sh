#!/bin/sh
# test/test-macos-universal.sh

set -e

distdir="`pwd`/dist"
luajit_bin="$distdir/osxuniversal/bin/luajit"
test_script="test/test-macos-universal.lua"

echo "==================================================="
echo "Testing Universal Binary Distribution"
echo "==================================================="

# Check if binary exists
if [ ! -f "$luajit_bin" ]; then
    echo "Error: luajit binary not found at $luajit_bin"
    exit 1
fi

# Check if it's actually a universal binary
echo "\nChecking binary architecture with 'file':"
file_output=$(file "$luajit_bin")
echo "$file_output"

echo "\nChecking architectures with 'lipo':"
lipo_output=$(lipo -info "$luajit_bin")
echo "$lipo_output"

# Verify both architectures are present
if ! echo "$lipo_output" | grep -q "x86_64"; then
    echo "Error: x86_64 architecture not found in binary"
    exit 1
fi

if ! echo "$lipo_output" | grep -q "arm64"; then
    echo "Error: arm64 architecture not found in binary"
    exit 1
fi

echo "✓ Both x86_64 and arm64 architectures confirmed"

# Test running as arm64
echo "\n==================================================="
echo "Testing as ARM64"
echo "==================================================="
arch -arm64 "$luajit_bin" "$test_script"

# Test running as x86_64
echo "\n==================================================="
echo "Testing as X86_64"
echo "==================================================="
arch -x86_64 "$luajit_bin" "$test_script"

echo "\n==================================================="
echo "All architecture tests passed!"
echo "==================================================="
