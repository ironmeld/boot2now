#!/usr/bin/env bash
set -euo pipefail

echo "src 0 builder-tools"

echo "src $(wc -c builder-tools/build-builder.kaem)"
cat builder-tools/build-builder.kaem

(
cd ../builder-hex0-with-stage0-posix || exit 1
echo "src $(wc -c builder-tools/build-builder-stage0-posix-srcs.kaem)"
cat builder-tools/build-builder-stage0-posix-srcs.kaem
echo "src $(wc -c builder-tools/build-builder-stage0-posix-cmds.kaem)"
cat builder-tools/build-builder-stage0-posix-cmds.kaem
)

echo "src $(wc -c builder-tools/build-builder-mes-srcs.kaem)"
cat builder-tools/build-builder-mes-srcs.kaem

echo "src $(wc -c builder-tools/build-builder-mes-cmds.kaem)"
cat builder-tools/build-builder-mes-cmds.kaem
