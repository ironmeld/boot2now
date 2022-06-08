all:
	make -C boot-stages
	make -C tool-steps
	make -C examples

clean:
	make -C boot-stages clean
	make -C tool-steps clean
	make -C examples clean

.PHONY: all clean
