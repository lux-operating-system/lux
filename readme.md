**luxOS** is a planned prototype Unix-like operating system that will be built on the [lux microkernel](https://github.com/lux-operating-system/kernel). This repository contains the build system for a disk image containing luxOS that can be booted on a virtual machine or on real hardware.

[![License: MIT](https://img.shields.io/github/license/lux-operating-system/kernel?color=red)](https://github.com/lux-operating-system/lux/blob/main/LICENSE) [![Build status](https://github.com/lux-operating-system/lux/actions/workflows/build-mac.yml/badge.svg)](https://github.com/lux-operating-system/lux/actions) [![GitHub Issues](https://img.shields.io/github/issues/lux-operating-system/lux)](https://github.com/lux-operating-system/lux/issues)

## Nightly Builds
If you prefer to build luxOS yourself, scroll down.

If you prefer to use a nightly build, build images will be generated every night at 3:00 AM GMT, and builds from the last 90 days are available under the [Actions tab](https://github.com/lux-operating-system/lux/actions/workflows/nightly-mac.yml).

## Building
### 1. Requisites
Before building luxOS, you will need to install several tools necessary to build the build system itself. You will need a cross compiler that can generate executables for luxOS regardless of your host system. The compiler used in the development of luxOS is gcc and the assembler is nasm.

This guide will assume you are running on a Unix-like system.

**You will need to install the following packages before proceeding:**
* working host C and C++ compilers (gcc and g++, or clang and clang++)
* nasm
* curl
* make
* autoconf (==2.69)
* automake (>=1.16)
* texinfo
* m4
* libgmp-dev (on Linux distributions)
* libgmp (on Linux distributions)
* qemu (for testing)

Many Unix-like systems ship with several of these packages installed. You may need to run one of the following commands depending on your system.

**macOS with Homebrew:**
```shell
brew install nasm curl make autoconf@2.69 automake texinfo m4 qemu
```

**Debian derivatives:**
```shell
sudo apt install nasm curl build-essential autoconf=2.69* automake texinfo m4 libgmp-dev libgmp qemu
```

### 2. Clone the repository
After all the dependencies are installed, recursively clone this repository and `cd` into it:
```shell
git clone --recurse-submodules https://github.com/lux-operating-system/lux
cd lux
```

### 3. Build the toolchain
The luxOS build system provides a script to automatically configure and build binutils and gcc to generate executables for luxOS.
```shell
cd toolchain-x86_64
./build-toolchain.sh
```

If this step was completed successfully, you should now have a toolchain targeting luxOS in `.../lux/toolchain-x86_64/cross/bin`. Add that path to your `PATH` and `cd` back into the luxOS root so that the rest of the build process can go smoothly.
```shell
export PATH="$PATH:.../lux/toolchain-x86_64/cross/bin"
cd ..
```

### 4. Build and run luxOS
Building a bootable disk image of luxOS is now as simple as running one command.
```shell
make
```

You should now have a file called `lux.hdd` in the project root. You can now run luxOS in QEMU by running:
```shell
make qemu
```

Or if you'd prefer to use another virtual machine, you can attach the virtual disk image to a VirtualBox VM or similar.

### 5. Optional: Cleanup
Many artifacts are generated from intermediate steps in the build process. If you are not planning to modify and rebuild luxOS, you may find it useful to delete them.
```shell
make clean
```

## License
The lux microkernel is free and open source software released under the terms of the MIT License. Unix is a registered trademark of The Open Group.

#

Made with 💗 from Boston and Cairo
