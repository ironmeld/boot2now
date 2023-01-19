# Note that prerequisites after `|` are order-only: timestamp changes do not trigger a rebuild.

MODULESDIR = ../../modules

BUILD/fiwix: ../builder-hex0-with-tcc-from-mes/BUILD/builder-hex0-with-tcc.bin \
	BUILD/builder-hex0-to-fiwix.src | BUILD 
	(cd BUILD; ../$(MODULESDIR)/builder-hex0/build.sh ../$< builder-hex0-to-fiwix.src fiwix)

BUILD/builder-hex0-to-fiwix.src: BUILD/fiwix.src BUILD/builder-fiwix-srcs.src
	# Add src and scripts for make and support files
	cp BUILD/fiwix.src $@
	# Add src and commands for builder-hex0-to-fiwix
	cat BUILD/builder-fiwix-srcs.src >> $@
	cat fiwix-and-builder-cmds.src >> $@

BUILD/fiwix.src: gather-fiwix-src.sh | BUILD
	./gather-fiwix-src.sh > $@

BUILD/builder-fiwix-srcs.src: ./gather-builder-fiwix-srcs.sh | BUILD
	./gather-builder-fiwix-srcs.sh > $@

../builder-hex0-with-tcc-from-mes/BUILD/builder-hex0-with-tcc.bin:
	make -C ../builder-hex0-with-tcc-from-mes

BUILD:
	mkdir BUILD

clean:
	rm -rf BUILD

.PHONY: clean
