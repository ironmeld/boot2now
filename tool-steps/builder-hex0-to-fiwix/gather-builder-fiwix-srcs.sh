#!/usr/bin/env bash
set -euo pipefail

echo "src 0 builder-tools"

echo "src $(wc -c builder-tools/build-builder.kaem)"
cat builder-tools/build-builder.kaem

echo "src $(wc -c builder-tools/build-builder-fiwix-srcs.kaem)"
cat builder-tools/build-builder-fiwix-srcs.kaem
echo "src $(wc -c builder-tools/build-builder-fiwix-cmds.kaem)"
cat builder-tools/build-builder-fiwix-cmds.kaem
