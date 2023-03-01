
kernel-bootstrap:
	make -C live-bootstrap-kernel-bootstrap

all:
	make -C boot-stages
	make -C tool-steps
	make -C examples
	make -C live-bootstrap-kernel-bootstrap

clean:
	make -C boot-stages clean
	make -C tool-steps clean
	make -C examples clean
	make -C live-bootstrap-kernel-bootstrap clean

.PHONY: all clean
