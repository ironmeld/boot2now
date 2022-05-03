# Levels of Trust

The strictness of your bootstrapping strategy stems from the amount of trust you are willing to accept.

I should note that if you just want to build your current development environment entirely from source, that is a much simpler problem and is largely solved. But you will have to start by trusting some existing set of development tools. See the Linux from Scratch project.

If your motivation is to minimize trusting stuff you have not built yourself, you should know that current boostrapping techniques require trusting vast oceans of source code spanning multiple versions of tools going back many decades. You may build it yourself, but it will be impractical to read it yourself. Ultimately, you will have to trust the source code being provided.

Moreover, you will need to use some existing tools to prepare inputs to the initial machine you will use. The hardware environment that this project targets (a PC) does not come with a standard human user interface for inputing the initial software directly. The BIOS reads a boot program from a well known location on a disc. Therefore, you MUST use existing tools to prepare that initial drive image. Explaining how to do that is therefore, by definition, beyond the scope of this project because we can only specify trusted tools as inputs to each phase. (One might think creating a console monitor and typing in hex code is better, but you still have to prepare a disk image with the monitor.)

From a practical perspective, the lack of a built-in user interface on old hardware means this project is not sufficient to bootstrap old hardware. A bare metal machine with a blank hard drive will not be salvageable unless you can move that hard drive to another operating machine from the same era that can write an initial boot image for that hard drive, and then move it back.

What I am getting at is that this project is neither practical nor pure in its principles. So be forewarned, the solution here may not be that satisfying for those reasons. I *personally* think it would be more satisfying than prior efforts and I am also motivated by the curiosity and the challenge. It remains to be seen whether that will be enough to sustain this project.
