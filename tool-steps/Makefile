all:
	make -C builder-hex0-with-stage0-posix
	make -C builder-hex0-with-mes-from-stage0-posix
	make -C builder-hex0-with-tcc-from-mes
	make -C builder-hex0-to-fiwix

clean:
	make -C builder-hex0-with-stage0-posix clean
	make -C builder-hex0-with-mes-from-stage0-posix clean
	make -C builder-hex0-with-tcc-from-mes clean
	make -C builder-hex0-to-fiwix clean

.PHONY: all clean
