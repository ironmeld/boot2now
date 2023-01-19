#!/usr/bin/env bash
set -euo pipefail

echo "src $(wc -c kaem.run)"
cat kaem.run

rm -rf BUILD/rootfs
mkdir -p BUILD/rootfs/sysa
cp ../../modules/live-bootstrap/sysa/checksum-transcriber.c BUILD/rootfs/sysa
cp ../../modules/live-bootstrap/sysa/checksum-transcriber.SHA256SUM BUILD/rootfs/sysa
cp -r ../../modules/live-bootstrap/sysa/mes-0.24.1 BUILD/rootfs/sysa
cp sysa-run.kaem-mes-only BUILD/rootfs/sysa/run.kaem
cp ../../modules/live-bootstrap/sysa/after.kaem BUILD/rootfs

(
cd BUILD/rootfs
tar czpf ../rootfs.tar.gz .
cd ..

echo "src $(wc -c rootfs.tar.gz)"
cat rootfs.tar.gz
)

# distfiles are separate because untar has trouble with the mes and nyacc tar files
echo "src 0 sysa"
echo "src 0 sysa/distfiles"
mkdir BUILD/rootfs/sysa/distfiles
cp ../../distfiles/mes-0.24.1.tar.gz BUILD/rootfs/sysa/distfiles
cp ../../distfiles/nyacc-1.00.2.tar.gz BUILD/rootfs/sysa/distfiles
(
cd BUILD/rootfs
echo "src $(wc -c sysa/distfiles/mes-0.24.1.tar.gz)"
cat sysa/distfiles/mes-0.24.1.tar.gz
echo "src $(wc -c sysa/distfiles/nyacc-1.00.2.tar.gz)"
cat sysa/distfiles/nyacc-1.00.2.tar.gz
)

echo "src 0 /sysa/bootstrap.cfg"

(
cd ../../utils
echo "src $(wc -c simple-patch.c)"
cat simple-patch.c
)

(
cd patches
echo "src $(wc -c mes-kaem.run-base-address.before)"
cat mes-kaem.run-base-address.before
echo "src $(wc -c mes-kaem.run-base-address.after)"
cat mes-kaem.run-base-address.after

echo "src $(wc -c mes-0.24.1.kaem-apply-patches.before)"
cat mes-0.24.1.kaem-apply-patches.before
echo "src $(wc -c mes-0.24.1.kaem-apply-patches.after)"
cat mes-0.24.1.kaem-apply-patches.after

echo "src $(wc -c mes-0.24.1.kaem-base-address.before)"
cat mes-0.24.1.kaem-base-address.before
echo "src $(wc -c mes-0.24.1.kaem-base-address.after)"
cat mes-0.24.1.kaem-base-address.after

echo "src $(wc -c mes-fix-hex-conversions.before)"
cat mes-fix-hex-conversions.before
echo "src $(wc -c mes-fix-hex-conversions.after)"
cat mes-fix-hex-conversions.after

echo "src $(wc -c mes-fix-hex-conversions2.before)"
cat mes-fix-hex-conversions2.before
echo "src $(wc -c mes-fix-hex-conversions2.after)"
cat mes-fix-hex-conversions2.after
)
