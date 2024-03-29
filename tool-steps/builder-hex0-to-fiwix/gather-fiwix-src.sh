#!/usr/bin/env bash
set -euo pipefail

echo "src $(wc -c kaem.run)"
cat kaem.run

rm -rf BUILD/rootfs
mkdir -p BUILD/rootfs/sysa

cp ../../modules/live-bootstrap/sysa/after.kaem BUILD/rootfs

cp -rp fiwix-live-bootstrap BUILD/rootfs/sysa/

cp run.kaem-fiwix-only BUILD/rootfs/sysa/run.kaem

(
cd BUILD/rootfs
tar -c -z -p -f ../rootfs.tar.gz .
cd ..

echo "src $(wc -c rootfs.tar.gz)"
cat rootfs.tar.gz
)

# sysa/distfiles are separate from rootfs because untar has trouble with the tar files
mkdir BUILD/rootfs/sysa/distfiles
cp ../../distfiles/fiwix-live-bootstrap.tar.gz BUILD/rootfs/sysa/distfiles

(
echo "src 0 sysa"
echo "src 0 sysa/distfiles"
cd BUILD/rootfs
echo "src $(wc -c sysa/distfiles/fiwix-live-bootstrap.tar.gz)"
cat sysa/distfiles/fiwix-live-bootstrap.tar.gz
)

echo "src 0 /sysa/bootstrap.cfg"
