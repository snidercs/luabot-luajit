# LuaJIT for WPILib

This repository contains build scripts to compile LuaJIT for various platforms, with a primary focus on cross-compiling for the FRC roboRIO (linuxathena). The goal is to provide a consistent build environment for creating LuaJIT binaries for use in FRC projects.

## Platforms

The build system is designed to support multiple host platforms and targets.

- **roboRIO**: The primary target. Binaries are cross-compiled using a Docker-based toolchain on all host platforms.
- **macOS**: Universal binary for both `x86_64` and `arm64` architectures.
- **Windows**: x86_64 binaries
- **Linux**: x86_64 binaries

## Build Process

The build process is managed by shell scripts and is currently optimized for macOS hosts.

### Prerequisites

- **Docker**: (all platforms) Required for cross-compiling for the roboRIO on all host platforms.
- **Xcode Command Line Tools** (macOS only): Required for compiling the native macOS universal binary. Install with `xcode-select --install`.
- **Visual Studio**: (windows only): 2019 or higher. install with Desktop c++ support
- **Git Bash**: Required for running shell scripts.
- **NSIS**: Required for creating the Windows installer. Make sure `makensis.exe` is in your `PATH`
- **GCC**: (linux): install by normal means for your distro.

### macOS Build

The `build-macos.sh` script automates the entire process on a macOS host. To run the full build process:
```sh
sh build-macos.sh
```

### macOS Install

To install the compiled binaries into `/opt/luabot` on a macOS machine for local development:
```sh
sudo sh install-macos.sh
```

### Windows Build

Building on Windows involves a few manual steps.

**Build Windows Native Binary**:
Open a Command Prompt and run `build-windows.bat`. This will compile LuaJIT for your native Windows architecture.

**Cross-Compile for roboRIO**
Open Git Bash. The following builds a Docker image and cross-compiles LuaJIT for the roboRIO.
```sh
sh build-roborio-docker.sh
```

**Create Installer**:
Build the installer using NSIS.
```batch
makensis setup.nsi
```

### Windows Install
Run the installer produced in the previous step. It should be named `luabot-win64-0.0.1-setup.exe` or something similar.
