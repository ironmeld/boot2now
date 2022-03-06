# Boot2Now: Minimal Bootstrapping

Minimized bootstrapping of foundational software is a process for building software tools progressively, from a primitive compiler tool and source language up to a full linux development environment with gcc.

At each stage of development, the tool should build a more capable version of itself using only source code input. Then the new version should be able to handle more sophisticated source code for the next phase.

Bootstrapping serves to isolate all inputs and outputs in the construction of software. Moreover, a stricter form of authentication includes auditing all tools used in the construction as well, recursively. A strict bootstrap-audit can only be satisfied by bootstrapping your tools from "scratch".

## Status

The project began in late February, 2022 and, currently, is in the very early stages.

The most evolved (and only) compiler in this project is [Builder-Hex0](https://github.com/ironmeld/builder-hex0).

## Why?

I would like to take a different approach from the existing projects. It is worth noting that there are not that many projects that are active and I am not sure any of them are complete. In other words, the field is not crowded with viable solutions.

Two of the bootstrap projects (Guix and live-bootstrap) I looked required a prebuilt linux kernel. The presumption appears to be that you cannot practically build a kernel without a subset of a POSIX kernel (or equivalent) that can execute a binary and handle commands to read from and write to a drive. These projects eventually build and transition to a kernel with that level of functionality but, in the mean time, they do not try to get there "by hand", i.e. without a POSIX kernel.

A typical C compiler needs to read source files and system headers and it uses kernel system calls to perform file I/O. However, a POSIX kernel is typically built with a C compiler. So, we have a chicken-or-the-egg question. Indeed, when Linus Torvalds released Linux 0.02 he was using minix to compile it. Linux was not self-hostable until version .11.

Nevertheless, I believe it is worth trying to build the operating system progressively in lock-step with the tool chain.

My goal is to minimize the (Effort to Understand Source * Volume of Source) while maximizing progress towards a linux distro.

Another difference with other projects is the method of input. The amount of code to be compiled to reach a modern toolchain with gcc is enormous. It cannot be typed in. We must present it to the machine via hardware. Possible solutions include interfacting with network interfaces, serial ports, and hard drives. A hard drives make the most sense to me. Other projects are focused on network access, the console, or serial ports.


## Existing Projects

### Bootstrappable

* https://bootstrappable.org
* https://github.com/oriansj/talk-notes/blob/master/bootstrappable.org

This project requires a linux kernel. This project targets Scheme as a foundational language.

### Live bootstrap

* https://github.com/fosslinux/live-bootstrap
* https://bootstrapping.miraheze.org/wiki/Live-bootstrap

This project requires a linux kernel. This project is fairly strict about [what it considers source code](https://github.com/fosslinux/live-bootstrap#specific-things-to-be-bootstrapped).

### asmc

* https://gitlab.com/giomasce/asmc

Aligned:
  * asmc targets Assembly and C and starts with minimal boot images, which is aligned with my thinking.
  * A tremendous amount of great embrionic boot loader and kernel code

Unaligned:
  * Unclear evolutionary process
  * Presumes nasm and starts with thousands of lines of assembly code
  * 6 kb seed is large
  * Presumes python and make
  * asmc eventually targets loading code via iPXE and a network card, which:
    * Significantly restricts the type of physical machine that are able to support that bootstrapping process.
    * Imposes a significant burden on the bootstrapper to setup a network and a PXE server external to the bootstrap machine.
    * Networking requires too much complexity to bootstrap manually

### tccboot

tccboot is a boot image that boots and builds a linux kernel from source.
https://bellard.org/tcc/tccboot.html

Building tccboot is still a bootstrapping challenge but once there, this project is very interesting.

### MinimalBinaryBoot

* https://codeberg.org/StefanK/MinimalBinaryBoot

Starts with a tiny monitor that allow entering octal.

## Levels of Trust

The strictness of your bootstrapping strategy stems from the amount of trust you are willing to accept.

I should note that if you just want to build your current development environment entirely from source, that is a much simpler problem and is largely solved. But you will have to start by trusting some existing set of development tools. See the Linux from Scratch project.

If your motivation is to minimize trusting stuff you have not built yourself, you should know that current boostrapping techniques require trusting vast oceans of source code spanning multiple versions of tools going back many decades. You may build it yourself, but it will be impractical to read it yourself. Ultimately, you will have to trust the source code being provided.

Moreover, you will need to use some existing tools to prepare inputs to the initial machine you will use. The hardware environment that this project targets (a PC) does not come with a standard human user interface for inputing the initial software directly. The BIOS reads a boot program from a well known location on a disc. Therefore, you MUST use existing tools to prepare that initial drive image. Explaining how to do that is therefore, by definition, beyond the scope of this project because we can only specify trusted tools as inputs to each phase. (One might think creating a console monitor and typing in hex code is better, but you still have to prepare a disk image with the monitor.)

From a practical perspective, the lack of a built-in user interface on old hardware means this project is not sufficient to bootstrap old hardware. A bare metal machine with a blank hard drive will not be salvageable unless you can move that hard drive to another operating machine from the same era that can write an initial boot image for that hard drive, and then move it back.

What I am getting at is that this project is neither practical nor pure in its principles. So be forewarned, the solution here may not be that satisfying for those reasons. I *personally* think it would be more satisfying than prior efforts and I am also motivated by the curiosity and the challenge. It remains to be seen whether that will be enough to sustain this project.

## Requirements

* The first translation must be simple enough to be performed by hand.
    * Minimize the size of the initial binary that must be hand constructed
    * Do not require an existing kernel

* Minimize the work for the auditor
    * Minimize the number of manual hardware transitions
    * Each phase should support source code which is progressively more expressive to reduce the sheer volume of overall auditable code.

* A proper audit requires the ability to audit all source artifacts that will be used as inputs.
* To be useful, The bootstrap must evolve to a set of modern linux kernel and development tools 
* The bootstrap requires starting from a specific environment (i.e. hardware, which may be virtualized).
* The bootstrap process may require transitions to more sophisticated environments (i.e. 32-bit to 64-bit machine)
* Boostraps tied to simpler hardware are easier to build.
* Boostraps tied to older hardware helps keeps that hardware alive, which is a positive.
* Older hardware and virtualizations of older hardware are fragile and difficult to maintain, which is a negative.

## Proposed Solution

Minimalism is prioritized by focusing on the most enduring hardware environment and the most enduring languages. The expected environment is a minimal 386 cpu with a minimal BIOS and minimal ATA hard drive support.

* The build process is functional and produces deterministic outputs at every stage
* The output of a build is a bootable image
* Independent auditors should produce and vouch for every bootable environment.
* People can used cached artifacts to the extent that they trust the auditors that have signed off on them.

Start with the simplist possible translation to a binary with minimal machine requirements that can be used to bootstrap further operating systems and compilers.

* The build process is functional.

```
build-image = builder-image + source
result-image = build-image()
```

The notation build-image() means we invoke the build by booting the image. Initially, the image can access itself by reading and writing the disc using the BIOS. It can also write a new image back to the disc via the BIOS. The function is complete when the system terminates.

* The first working system is launched from a "hand built" bootable image.

* Every transition should preserve a bootable software environment which is checksumed and cryptographically signed. These are the Master Bootstrap Images.
  * capture image
  * launch
  * build
  * shutdown
  * capture image

## Build2Now Structure

A Build2Now compiler includes:
   * a bootable image of the compiler
   * sha256 checksum of the compiler image
   * sha256 checksum of (parent) image that compiled the compiler
   * sha256 checksum of source provided to the parent compiler

Each builder in the Build2Now series defines:
   * A hardware interface
   * An operating system interface to access hardware and other operating system facilities
   * A system-specific language library interface to access the operating system
   * An application language which uses the system interface library
   * Comes with its own source by default and builds itself when invoked
   * Instructions on how to provide source
   * Instructions on how to extract output - what is the length?


### Reference

linux .02 was the first runnable version and required gcc 1.40 and minix:
* https://www.cs.cmu.edu/~awb/linux.history.html
* https://virtuallyfun.com/wordpress/2010/08/13/linux-0-00-0-11-on-qemu/

Linux source:
* https://elixir.bootlin.com/linux/0.10/source

PC source:
* https://tldp.org/HOWTO/Large-Disk-HOWTO-4.html

Compiler:
* https://miyuki.github.io/2017/10/04/gcc-archaeology-1.html
* http://download.savannah.gnu.org/releases/tinycc/

Like Linux from scratch
* https://buildroot.uclibc.org/

Libc from scratch
* https://github.com/jart/cosmopolitan

Small posix utilities:
https://c9x.me/yacc/
