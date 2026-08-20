#!/bin/sh

set -e

export CC=clang
export UBSAN_OPTIONS=print_stacktrace=1

# charmonizer doesn't allow to specify linker flags, so we patch the
# Makefile manually.

cd compiler/c
./configure -- \
    -fsanitize=address,undefined \
    -fno-sanitize-recover=all \
    -fno-omit-frame-pointer
sed -i -e 's/CFC_EXE_LDFLAGS = /&-fsanitize=address,undefined /' Makefile
make
ASAN_OPTIONS=detect_leaks=0 make test

cd ../../runtime/c
./configure -- \
    -fsanitize=address,undefined \
    -fno-sanitize=function \
    -fno-sanitize-recover=all \
    -fno-omit-frame-pointer
sed -i -e 's/LDFLAGS = /&-fsanitize=address,undefined /' Makefile
make
make test
