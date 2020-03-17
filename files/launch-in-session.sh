#!/bin/sh
if [ "$#" -ne 2 ]; then
    echo "USAGE: $0 SESSION CMD"
    exit
fi
​
screen -qXS $1 quit
screen -dmS $1 $2
