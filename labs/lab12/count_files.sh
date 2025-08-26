#!/bin/bash 

if [ $# -lt 2 ]; then 
    echo "Использования: ./count.files.sh <расширение> <папка>"
    echo "Пример ./count_files.sh .txt /home/user/documents"
    exit 1
fi

extension="$1"
folder="$2"

count=0 
for file in "$folder"/*"$extension"; do 
    if [ -f "$file" ]; then
       count=$((count + 1))
    fi
done 

echo "В папке '$folder' найдено $count файлов с расширением '$extension'"
