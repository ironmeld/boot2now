# Overview

The tool steps in this directory are used to build a disk image with a set of tools and compilers.

Once the image is created, you can write source code and commands into the image and then launch the image to build whatever you want.
For an automated example of this process, see the Makefile in each directory.

The following is the list of tool steps:

## builder-hex0-M2

The builder-hex0 boot kernel/compiler is combined with the stage0-posix compilers to produce an image with:

* The builder-hex0 boot kernel/compiler with:
  * An internal shell
  * A src utility for reading source files into the memory file system
  * A hex0 compiler

* And these stage0-posix executables (in the x86/bin directory)::
  *  M1
  *  M2-Mesoplanet
  *  M2-Planet
  *  blood-elf
  *  catm
  *  chmod
  *  cp
  *  get_machine
  *  hex2
  *  kaem
  *  match
  *  mkdir
  *  placeholder
  *  sha256sum
  *  ungz
  *  untar

* And these tools for creating a new builder image:
  * The builder-hex0 boot kernel in the file `builder-hex0.bin`
  * A utility named `x86/bin/src-header` for producing src headers
