#!/usr/bin/env bash
set -euo pipefail

echo "src $(wc -c helloworld.c)"
cat helloworld.c

echo "src $(wc -c kaem.run)"
cat kaem.run

echo "x86/bin/kaem --verbose"
