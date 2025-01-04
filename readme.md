<div align="center">

[![luxOS logo](https://jewelcodes.io/lux/logo-small.png)](https://github.com/lux-operating-system)

[![License: MIT](https://img.shields.io/github/license/lux-operating-system/lux?color=red)](https://github.com/lux-operating-system/lux/blob/main/LICENSE) [![Build status](https://github.com/lux-operating-system/lux/actions/workflows/build-mac.yml/badge.svg)](https://github.com/lux-operating-system/lux/actions) [![GitHub Issues](https://img.shields.io/github/issues/lux-operating-system/lux)](https://github.com/lux-operating-system/lux/issues)

#

</div>

**luxOS** is a planned prototype Unix-like operating system that will be built on the [lux microkernel](https://github.com/lux-operating-system/kernel). This repository contains the build system for a disk image containing luxOS that can be booted on a virtual machine or on real hardware, as well as the overall project roadmap.

![Screenshot of luxOS running on QEMU](https://jewelcodes.io/lux-01-03-25.png)

# Nightly Builds
If you prefer to build luxOS yourself, scroll down.

If you prefer to use a nightly build, build images will be generated every night at 3:00 AM GMT, and builds from the last 90 days are available under the [Actions tab](https://github.com/lux-operating-system/lux/actions/workflows/nightly-mac.yml).

# Building
## 1. Requisites
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

## 2. Clone the repository
After all the dependencies are installed, recursively clone this repository and `cd` into it:
```shell
git clone --recurse-submodules https://github.com/lux-operating-system/lux
cd lux
```

## 3. Build the toolchain
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

## 4. Build and run luxOS
Building a bootable disk image of luxOS is now as simple as running one command.
```shell
make
```

You should now have a file called `lux.hdd` in the project root. You can now run luxOS in QEMU by running:
```shell
make qemu
```

Or if you'd prefer to use another virtual machine, you can attach the virtual disk image to a VirtualBox VM or similar.

## 5. Optional: Cleanup
Many artifacts are generated from intermediate steps in the build process. If you are not planning to modify and rebuild luxOS, you may find it useful to delete them.
```shell
make clean
```

# Progress Checklist

This checklist provides a rough overview of the backlog for the luxOS project. It is not meant to be all-inclusive and is subject to change as more components of the system are developed and/or if the vision or design changes.

- [ ] **Milestone 0: Requisite to all other milestones:**
  - [x] Priority scheduling
  - [x] Multiprocessing
  - [x] Multithreaded and preemptible microkernel
  - [x] User space
  - [x] C library (partial)
  - [ ] C++ library
  - [x] Unix domain sockets
  - [x] POSIX signals
  - [x] Standard communication protocol for microkernel servers
  - [x] Framework for drivers running in user space
  - [x] Unix-like `/dev` file system
  - [x] Unix-like `/proc` file system (partial)
  - [ ] Anonymous pipes
  - [ ] Named pipes
  - [ ] Wildcards
  - [x] At **least** one read-write storage device driver:
      - [x] NVMe SSDs
      - [ ] AHCI (SATA SSDs and HDDs)
      - [ ] IDE (ATA HDDs)
  - [x] At **least** one read-write file system driver with enforced Unix permissions:
      - [x] lxfs
      - [ ] ext2
      - [ ] ext3/4
  - [x] Keyboard input
  - [x] Unix-style pseudo-terminal driver
  - [x] Terminal emulator with support for ANSI control codes
  - [ ] Port ncurses
  - [ ] Port **one** shell:
    - [ ] zsh (preferred)
    - [ ] bash

- [ ] **Milestone 1: Independence and self-hosting:**

	- [ ] Port binutils
	- [ ] Port GCC
	- [ ] Port NASM
	- [ ] Port make
	- [x] Port a simple text editor
	- [ ] Edit and recompile the OS running under itself

- [ ] **Milestone 2: Networking:**

	- [ ] At **least** one ethernet device driver:
      - [ ] NE2000 (Bochs and QEMU)
      - [ ] Realtek RTL8139 (QEMU)
      - [ ] Realtek RTL8111/RTL8169 (real hardware)
      - [ ] AMD PC-NET (VirtualBox)
      - [ ] Intel i8254x (QEMU and VirtualBox)
	- [ ] TCP/IP stack with support for IPv4 and IPv6
	    - [ ] DHCP client implementation
	    - [ ] DNS lookup implementation
	- [ ] Port OpenSSL for secure TCP connections
	- [ ] Port wget and/or curl
	- [ ] Port git
	- [ ] Port ssh
	- [ ] Package and repository manager

- [ ] **Milestone 3: USB:**

	- [ ] Device driver for xHCI (USB 3.x)
	- [ ] Device driver for USB hubs
	- [ ] Drivers for USB HIDs (keyboards and mice)
	- [ ] Driver for USB mass storage devices
	- [ ] Driver for USB ethernet controllers

- [ ] **Milestone 4: Iris (graphical user interface):**

	- [ ] Display manager
	- [ ] Compositor
	- [ ] Windowing system
	- [ ] Graphical terminal emulator
	- [ ] Graphical file manager
	- [ ] Frontends for common command-line utilities

- [ ] **Milestone 5: Port from x86_64 to ARM64:**

	- [ ] **TODO:** Specifics yet to be decided

# Contributing

The lux microkernel and the luxOS Project are both personal educational/research projects and are not planned to be community-developed. However, if you like what you're seeing and/or you learned something, monetary contributions would be greatly appreciated and provide a direct incentive to allocate more time to the project. You can support my work on [Patreon](https://patreon.com/luxOS) if you're interested.

# Contact
Join the project's [Discord server](https://discord.gg/GEeekQEgaB) if you just wanna say hi or talk about OS development in general.

# License
The lux microkernel is free and open source software released under the terms of the MIT License. Unix is a registered trademark of The Open Group.

#

Made with 💗 from Boston and Cairo
