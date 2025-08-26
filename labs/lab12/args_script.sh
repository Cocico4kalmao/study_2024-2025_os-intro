#!/bin/bash

echo "Вы передали $# аргументов:"

echo "Все аргументы: $@"

i=1
for arg in "$@"; do 
    echo "Аргумент $i: $arg"
    i=$((i+1))
done
