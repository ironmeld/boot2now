# Note that prerequisites after `|` are order-only: timestamp changes do not trigger a rebuild.

MODULESDIR = ../../modules
TOOLSDIR = ../../tool-steps

BUILD/builder-helloworld.bin: \
     $(TOOLSDIR)/builder-hex0-with-tcc-from-mes/BUILD/builder-hex0-with-tcc.bin \
     BUILD/helloworld.src
	(cd BUILD;../$(MODULESDIR)/builder-hex0/build.sh ../$< helloworld.src helloworld)
	chmod u+x BUILD/helloworld
	BUILD/helloworld

BUILD/helloworld.src: gather-helloworld-src.sh | BUILD
	./gather-helloworld-src.sh > $@

$(TOOLSDIR)/builder-hex0-with-tcc-from-mes/BUILD/builder-hex0-with-tcc.bin:
	make -C $(TOOLSDIR)/builder-hex0-with-tcc-from-mes

BUILD:
	mkdir BUILD

clean:
	rm -rf BUILD

.PHONY: clean
