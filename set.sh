#!/bin/bash

# liga o debug
set -x 

i=$((3+4))

date | cut -c1-3

echo $(echo $(echo $(echo $(echo oi))))

# desliga o debug
set +x

echo $(echo $(echo $(echo $(echo oi))))



