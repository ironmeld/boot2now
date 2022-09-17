# Note that prerequisites after `|` are order-only: timestamp changes do not trigger a rebuild.

MODULESDIR=../../modules
STAGE0POSIX=$(MODULESDIR)/live-bootstrap/sysa/stage0-posix/src

BUILD/builder-hex0-mini.bin: $(MODULESDIR)/builder-hex0/builder-hex0-mini.hex0 | BUILD
	$(STAGE0POSIX)/bootstrap-seeds/POSIX/x86/hex0-seed $< $@

BUILD:
	mkdir BUILD

clean:
	rm -rf BUILD

.PHONY: clean
