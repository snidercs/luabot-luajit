# LuaJIT for WPILib

This repository contains build scripts to compile LuaJIT for various platforms, with a primary focus on cross-compiling for the FRC roboRIO (linuxathena). The goal is to provide a consistent build environment for creating LuaJIT binaries for use in FRC projects.

## Platforms

The build system is designed to support multiple host platforms and targets.

### Target Platforms
- **roboRIO (linuxathena)**: The primary target. Binaries are cross-compiled using a Docker-based toolchain.
- **macOS**: Currently implemented. The scripts build a universal binary for both `x86_64` and `arm64` architectures.
- **Windows**: To be done.
- **Linux**: To be done.

## Build Process

The build process is managed by shell scripts and is currently optimized for macOS hosts.

### Prerequisites

- **Docker**: Required for cross-compiling for the roboRIO on all host platforms.
- **Xcode Command Line Tools** (macOS only): Required for compiling the native macOS universal binary. Install with `xcode-select --install`.

### macOS Build Instructions

The `build-macos.sh` script automates the entire process on a macOS host.

1.  **Build macOS Universal Binary**:
    -   Compiles LuaJIT for `x86_64` and `arm64`.
    -   Combines them into a universal binary using `lipo`.

2.  **Cross-Compile for roboRIO**:
    -   Builds a Docker image with the WPILib cross-compilation toolchain.
    -   Compiles LuaJIT for the roboRIO inside the container.

To run the full build process:
```sh
sh build-macos.sh
```

### Build Artifacts

All compiled binaries are placed in the `dist/` directory:
-   `dist/osxuniversal/`: Universal binaries for macOS.
-   `dist/linuxathena/`: Binaries cross-compiled for the roboRIO.

### Installation (macOS)

To install the compiled binaries into `/opt/luabot` on a macOS machine for local development:
```sh
sudo sh install-macos.sh
```

### Testing (macOS)

To verify the macOS universal binary, run the test script. It confirms that both `x86_64` and `arm64` architectures are present and executable.
```sh
sh test/test-macos-universal.sh
```
