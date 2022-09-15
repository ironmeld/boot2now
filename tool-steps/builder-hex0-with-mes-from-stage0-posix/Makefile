# Note that prerequisites after `|` are order-only: timestamp changes do not trigger a rebuild.

MODULESDIR = ../../modules

BUILD/builder-hex0-with-mes.bin: ../builder-hex0-with-stage0-posix/BUILD/builder-hex0-with-stage0-posix.bin \
		BUILD/builder-hex0-with-mes.src | BUILD 
	(cd BUILD; ../$(MODULESDIR)/builder-hex0/build.sh ../$< builder-hex0-with-mes.src builder-hex0-with-mes.bin)

BUILD/builder-hex0-with-mes.src: BUILD/mes.src BUILD/builder-mes-srcs.src
	# Add src and scripts for mes executables and support files
	cp BUILD/mes.src $@
	# Add src and commands for builder-hex0-with-mes
	cat BUILD/builder-mes-srcs.src >> $@
	cat mes-and-builder-cmds.src >> $@

BUILD/mes.src: gather-mes-src.sh | BUILD
	./gather-mes-src.sh > $@

BUILD/builder-mes-srcs.src: ./gather-builder-mes-srcs.sh | BUILD
	./gather-builder-mes-srcs.sh > $@

../builder-hex0-with-stage0-posix/BUILD/builder-hex0-with-stage0-posix.bin:
	make -C ../builder-hex0-with-stage0-posix

BUILD:
	mkdir BUILD

clean:
	rm -rf BUILD

.PHONY: clean
