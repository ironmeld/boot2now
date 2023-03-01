patch-and-run-live-bootstrap:
	make patch-live-bootstrap
	make run-live-bootstrap

patch-live-bootstrap:
	make clean
	./patch-live-bootstrap.sh

run-live-bootstrap:
	(cd BUILD/live-bootstrap;./rootfs.py --qemu --kernel-bootstrap)

clean:
	rm -rf BUILD

.PHONY: run-live-bootstrap patch-live-bootstrap clean
