#!/usr/bin/env bash

set -e

(cd builder-hex0 && make)

# Get copy of builder image
cp builder-hex0/builder-hex0.img .

# gather source
{
  # helloworld.c
  echo -n "src "
  wc -l ./helloworld.c
  cat ./helloworld.c

  # add after.kaem which builds and runs helloworld
  echo -n "src "
  wc -l ./after.kaem
  cat ./after.kaem

  ./gather-source.sh

  # finish with builder self build
  echo -n "src "
  cd builder-hex0
  wc -l ./builder-hex0.hex0
  cat ./builder-hex0.hex0
  cd ..

  echo "hex0 ./builder-hex0.hex0 /dev/hda"
} > input.src

# Apply source
dd if=input.src of=builder-hex0.img bs=512 seek=8 conv=notrunc
# Launch build
qemu-system-x86_64 -m 256M -nographic -drive file=builder-hex0.img,format=raw --no-reboot | tee build.log

# get result
lengthhex=$(tail -1 build.log | tr -d '\r')
length=$(printf "%d\n" $((16#$lengthhex)))

echo "$length"

# Extract the result
dd if=builder-hex0.img of=result.img bs=1 count="$length" status=none

diff result.img builder-hex0/builder-hex0.bin
