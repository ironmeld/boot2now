# Note that prerequisites after `|` are order-only: timestamp changes do not trigger a rebuild.

MODULESDIR=../../modules

BUILD/builder-hex0-mini.bin: $(MODULESDIR)/builder-hex0/builder-hex0-mini.hex0 | BUILD
	$(MODULESDIR)/stage0-posix/bootstrap-seeds/POSIX/x86/hex0-seed $< $@

BUILD:
	mkdir BUILD

clean:
	rm -rf BUILD

.PHONY: clean
