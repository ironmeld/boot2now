#!/usr/bin/env bash
set -euo pipefail

echo "src $(wc -c kaem.run)"
cat kaem.run

rm -rf BUILD/rootfs
mkdir -p BUILD/rootfs/sysa
cp -rp --dereference \
    ../../modules/live-bootstrap/sysa/mes-0.24.1 \
    ../../modules/live-bootstrap/sysa/tcc-0.9.26 \
    ../../modules/live-bootstrap/sysa/tcc-0.9.27 \
    BUILD/rootfs/sysa

cp run.kaem.tcc-only BUILD/rootfs/sysa/run.kaem
(cd BUILD/rootfs;patch --silent -p0 < ../../tcc-0.9.26.kaem.patch)
(cd BUILD/rootfs;patch --silent -p0 < ../../tcc-0.9.27.kaem.patch)
cp ../../modules/live-bootstrap/sysa/after.kaem BUILD/rootfs

(
cd BUILD/rootfs
tar -c -z -p -f ../rootfs.tar.gz .
cd ..

echo "src $(wc -c rootfs.tar.gz)"
cat rootfs.tar.gz
)

# sysa/distfiles are separate from rootfs because untar has trouble with the mes and nyacc tar files
mkdir BUILD/rootfs/sysa/distfiles
cp ../../distfiles/mes-0.24.1.tar.gz BUILD/rootfs/sysa/distfiles
cp ../../distfiles/nyacc-1.00.2.tar.gz BUILD/rootfs/sysa/distfiles
cp ../../distfiles/tcc-0.9.26.tar.gz BUILD/rootfs/sysa/distfiles
cp ../../distfiles/tcc-0.9.27.tar.bz2 BUILD/rootfs/sysa/distfiles
(
echo "src 0 sysa"
echo "src 0 sysa/distfiles"
cd BUILD/rootfs
echo "src $(wc -c sysa/distfiles/mes-0.24.1.tar.gz)"
cat sysa/distfiles/mes-0.24.1.tar.gz
echo "src $(wc -c sysa/distfiles/nyacc-1.00.2.tar.gz)"
cat sysa/distfiles/nyacc-1.00.2.tar.gz
echo "src $(wc -c sysa/distfiles/tcc-0.9.26.tar.gz)"
cat sysa/distfiles/tcc-0.9.26.tar.gz
echo "src $(wc -c sysa/distfiles/tcc-0.9.27.tar.bz2)"
cat sysa/distfiles/tcc-0.9.27.tar.bz2
)

echo "src 0 /sysa/bootstrap.cfg"

(
cd ../../utils
echo "src $(wc -c simple-patch.c)"
cat simple-patch.c
)

(
cd patches
echo "src $(wc -c remove-fileopen.before)"
cat remove-fileopen.before
echo "src $(wc -c remove-fileopen.after)"
cat remove-fileopen.after

echo "src $(wc -c addback-fileopen.before)"
cat addback-fileopen.before
echo "src $(wc -c addback-fileopen.after)"
cat addback-fileopen.after

echo "src $(wc -c fiwix-paddr.before)"
cat fiwix-paddr.before
echo "src $(wc -c fiwix-paddr.after)"
cat fiwix-paddr.after

echo "src $(wc -c mes-fix-hex-conversions.before)"
cat mes-fix-hex-conversions.before
echo "src $(wc -c mes-fix-hex-conversions.after)"
cat mes-fix-hex-conversions.after
echo "src $(wc -c mes-fix-hex-conversions2.before)"
cat mes-fix-hex-conversions2.before
echo "src $(wc -c mes-fix-hex-conversions2.after)"
cat mes-fix-hex-conversions2.after
)

