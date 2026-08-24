#!/bin/sh

set -e

cd compiler/c
./configure
make
make test

cd ../../runtime/c
./configure
make
make test
