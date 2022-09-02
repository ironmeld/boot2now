# Note that prerequisites after `|` are order-only: timestamp changes do not trigger a rebuild.

MODULESDIR=../../modules

BUILD/builder-hex0.bin: ../builder-hex0-mini/BUILD/builder-hex0-mini.bin $(MODULESDIR)/builder-hex0/builder-hex0.hex0 | BUILD
	(cd BUILD && \
		../$(MODULESDIR)/builder-hex0/build-mini.sh \
		../$< \
		../$(MODULESDIR)/builder-hex0/builder-hex0.hex0 \
		3584 \
		builder-hex0.bin)

../builder-hex0-mini/BUILD/builder-hex0-mini.bin:
	make -C ../builder-hex0-mini

BUILD:
	mkdir BUILD

clean:
	rm -rf BUILD

.PHONY: clean
