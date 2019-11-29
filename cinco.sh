#!/bin/bash

set -x

#liga o passo a passo
trap read DEBUG


echo $((0+1))
echo $((0+2))

set +x

#desliga o passo a passo
trap "" DEBUG

#liga o debug
set -xv

echo $((0+3))

#desliga o debug
set +xv

echo $((0+4))
echo $((0+5))


