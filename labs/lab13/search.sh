#!/bin/bash

# Инициализация переменных
input_file=""
output_file=""
pattern=""
case_sensitive=0
show_numbers=0

# Обработка ключей командной строки
while getopts "i:o:p:Cn" opt; do
    case $opt in
        i) input_file="$OPTARG" ;;
        o) output_file="$OPTARG" ;;
        p) pattern="$OPTARG" ;;
        C) case_sensitive=1 ;;
        n) show_numbers=1 ;;
        *) echo "Использование: $0 -i inputfile -o outputfile -p pattern [-C] [-n]"
           exit 1 ;;
    esac
done

# Проверка обязательных параметров
if [ -z "$input_file" ] || [ -z "$output_file" ] || [ -z "$pattern" ]; then
    echo "Ошибка: Необходимо указать входной файл, выходной файл и шаблон"
    echo "Использование: $0 -i inputfile -o outputfile -p pattern [-C] [-n]"
    exit 1
fi

# Проверка существования входного файла
if [ ! -f "$input_file" ]; then
    echo "Ошибка: Файл '$input_file' не существует"
    exit 1
fi

# Формирование команды grep
grep_cmd="grep"

# Добавление опций в зависимости от флагов
if [ $case_sensitive -eq 1 ]; then
    grep_cmd="$grep_cmd"
else
    grep_cmd="$grep_cmd -i"
fi

if [ $show_numbers -eq 1 ]; then
    grep_cmd="$grep_cmd -n"
fi

# Выполнение поиска и запись результата
$grep_cmd "$pattern" "$input_file" > "$output_file"

echo "Поиск завершен. Результат записан в '$output_file'"
