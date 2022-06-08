# Note that prerequisites after `|` are order-only: timestamp changes do not trigger a rebuild.

MODULESDIR=../../modules

BUILD/builder-hex0-with-stage0-posix.bin: ../../boot-stages/builder-hex0/BUILD/builder-hex0.bin \
		BUILD/builder-hex0-with-stage0-posix.src | BUILD
	(cd BUILD; ../$(MODULESDIR)/builder-hex0/build.sh ../$< builder-hex0-with-stage0-posix.src builder-hex0-with-stage0-posix.bin)

BUILD/builder-hex0-with-stage0-posix.src: BUILD/stage0-posix-srcs.src BUILD/stage0-posix-builder-tools-srcs.src
	# Add sources and commands for stage0-posix executables and support files
	cp BUILD/stage0-posix-srcs.src $@
	cat stage0-posix-cmds.src >> $@
	# Add sources and commands for builder-stage0-posix
	cat BUILD/stage0-posix-builder-tools-srcs.src >> $@
	cat builder-stage0-posix-cmds.src >> $@

BUILD/stage0-posix-srcs.src: ./gather-stage0-posix-srcs.sh | BUILD
	./$< > $@

BUILD/stage0-posix-builder-tools-srcs.src: ./gather-stage0-posix-builder-tools-srcs.sh | BUILD
	./$< > $@

../../boot-stages/builder-hex0/BUILD/builder-hex0.bin:
	make -C ../builder-hex0

BUILD:
	mkdir BUILD

clean:
	rm -rf BUILD

.PHONY: clean
