#!/bin/sh

cd compiler/perl
perl Build.PL
./Build
./Build test

cd ../../runtime/perl
perl Build.PL
./Build
./Build test
