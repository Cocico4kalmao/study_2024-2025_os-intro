#!/bin/bash

folder="${1:-.}"

echo "Файлы в папке '$folder':"
echo "------------------------"

for file in "$folder"/*; do
    if [ -f "$file" ]; then 
       echo "Файл: $(basename "$file")"
    elif [ -d "$file" ]; then 
       echo "Папка: $(basename "$file")"
    fi
done
