# Note that prerequisites after `|` are order-only: timestamp changes do not trigger a rebuild.

MODULESDIR = ../../modules

BUILD/builder-hex0-with-tcc.bin: ../builder-hex0-with-mes-from-stage0-posix/BUILD/builder-hex0-with-mes.bin \
	BUILD/builder-hex0-with-tcc.src | BUILD 
	(cd BUILD; ../$(MODULESDIR)/builder-hex0/build.sh ../$< builder-hex0-with-tcc.src builder-hex0-with-tcc.bin)

BUILD/builder-hex0-with-tcc.src: BUILD/tcc.src BUILD/builder-tcc-srcs.src
	# Add src and scripts for tcc executables and support files
	cp BUILD/tcc.src $@
	# Add src and commands for builder-hex0-with-tcc
	cat BUILD/builder-tcc-srcs.src >> $@
	cat tcc-and-builder-cmds.src >> $@

BUILD/tcc.src: gather-tcc-src.sh | BUILD
	./gather-tcc-src.sh > $@

BUILD/builder-tcc-srcs.src: ./gather-builder-tcc-srcs.sh | BUILD
	./gather-builder-tcc-srcs.sh > $@

../builder-hex0-with-mes-from-stage0-posix/BUILD/builder-hex0-with-mes.bin:
	make -C ../builder-hex0-with-mes-from-stage0-posix

BUILD:
	mkdir BUILD

clean:
	rm -rf BUILD

.PHONY: clean
