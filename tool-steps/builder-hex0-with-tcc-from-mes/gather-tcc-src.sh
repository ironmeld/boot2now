#!/usr/bin/env bash
set -euo pipefail

echo "src $(wc -c kaem.run)"
cat kaem.run

rm -rf BUILD/rootfs
mkdir -p BUILD/rootfs/sysa
cp -rp \
    ../../modules/live-bootstrap/sysa/mes-0.24 \
    ../../modules/live-bootstrap/sysa/tcc-0.9.26 \
    BUILD/rootfs/sysa

cp run.kaem.tcc-only BUILD/rootfs/sysa/run.kaem
cp tcc-0.9.26.kaem BUILD/rootfs/sysa/tcc-0.9.26
cp ../../modules/live-bootstrap/sysa/after.kaem BUILD/rootfs
cp SHA256SUMS.sources BUILD/rootfs/sysa

(
cd BUILD/rootfs
tar -c -z -p -f ../rootfs.tar.gz .
cd ..

echo "src $(wc -c rootfs.tar.gz)"
cat rootfs.tar.gz
)

# sysa/distfiles are separate from rootfs because untar has trouble with the mes and nyacc tar files
mkdir BUILD/rootfs/sysa/distfiles
cp ../../distfiles/mes-0.24.tar.gz BUILD/rootfs/sysa/distfiles
cp ../../distfiles/nyacc-1.00.2.tar.gz BUILD/rootfs/sysa/distfiles
cp ../../distfiles/tcc-0.9.26.tar.gz BUILD/rootfs/sysa/distfiles
(
echo "src 0 sysa"
echo "src 0 sysa/distfiles"
cd BUILD/rootfs
echo "src $(wc -c sysa/distfiles/mes-0.24.tar.gz)"
cat sysa/distfiles/mes-0.24.tar.gz
echo "src $(wc -c sysa/distfiles/nyacc-1.00.2.tar.gz)"
cat sysa/distfiles/nyacc-1.00.2.tar.gz
echo "src $(wc -c sysa/distfiles/tcc-0.9.26.tar.gz)"
cat sysa/distfiles/tcc-0.9.26.tar.gz
)

echo "src 0 /sysa/bootstrap.cfg"


echo "src $(wc -c simple-patch.c)"
cat simple-patch.c

(
cd patches
echo "src $(wc -c mes-increase-files.before)"
cat mes-increase-files.before
echo "src $(wc -c mes-increase-files.after)"
cat mes-increase-files.after

echo "src $(wc -c remove-fileopen.before)"
cat remove-fileopen.before
echo "src $(wc -c remove-fileopen.after)"
cat remove-fileopen.after

echo "src $(wc -c addback-fileopen.before)"
cat addback-fileopen.before
echo "src $(wc -c addback-fileopen.after)"
cat addback-fileopen.after
)

