# Note that prerequisites after `|` are order-only: timestamp changes do not trigger a rebuild.

MODULESDIR = ../../modules
TOOLSDIR = ../../tool-steps

BUILD/builder-helloworld.bin: $(TOOLSDIR)/builder-hex0-with-stage0-posix/BUILD/builder-hex0-with-stage0-posix.bin BUILD/helloworld.src
	(cd BUILD;../$(MODULESDIR)/builder-hex0/build.sh ../$< helloworld.src helloworld)
	chmod u+x BUILD/helloworld
	BUILD/helloworld

BUILD/helloworld.src: gather-helloworld-src.sh | BUILD
	./gather-helloworld-src.sh > $@

BUILD:
	mkdir BUILD

clean:
	rm -rf BUILD

.PHONY: clean
