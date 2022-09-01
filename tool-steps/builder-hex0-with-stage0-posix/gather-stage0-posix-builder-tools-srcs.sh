#!/usr/bin/env bash
set -euo pipefail

echo "src $(wc -c kaem.run)"
cat kaem.run

echo "src 0 builder-tools"

echo "src $(wc -c builder-tools/build-builder.kaem)"
cat builder-tools/build-builder.kaem

echo "src $(wc -c builder-tools/build-builder-stage0-posix-srcs.kaem)"
cat builder-tools/build-builder-stage0-posix-srcs.kaem

echo "src $(wc -c builder-tools/build-builder-stage0-posix-cmds.kaem)"
cat builder-tools/build-builder-stage0-posix-cmds.kaem

echo "src $(wc -c builder-tools/build-builder-utils.kaem)"
cat builder-tools/build-builder-utils.kaem

echo "src $(wc -c builder-tools/src-header.c)"
cat builder-tools/src-header.c

mkdir -p BUILD/builder-tools
cp ../../modules/builder-hex0/builder-hex0.hex0 BUILD/builder-tools
cd BUILD || exit 1
echo "src $(wc -c builder-tools/builder-hex0.hex0)"
cat builder-tools/builder-hex0.hex0
