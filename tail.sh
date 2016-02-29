#!/bin/bash
if [ -n "$2" ]; then
    cat -n $1 | tail -n $2
else
    cat -n $1 | tail -n 36
fi
