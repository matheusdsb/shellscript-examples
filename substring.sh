#!/bin/bash

test $# -ne 2 && exit

echo $2 | grep -qs $1 && echo "$1 esta contida em $2"


