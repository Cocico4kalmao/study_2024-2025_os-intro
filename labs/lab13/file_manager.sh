#!/bin/bash

# Функция для создания файлов
create_files() {
    local count=$1
    local i=1
    
    echo "Создание $count файлов..."
    while [ $i -le $count ]; do
        touch "${i}.tmp"
        echo "Создан файл: ${i}.tmp"
        i=$((i + 1))
    done
    echo "Файлы созданы успешно!"
}

# Функция для удаления файлов
delete_files() {
    echo "Удаление файлов *.tmp..."
    local deleted_count=0
    
    for file in *.tmp; do
        if [ -f "$file" ]; then
            rm "$file"
            echo "Удален: $file"
            deleted_count=$((deleted_count + 1))
        fi
    done
    
    if [ $deleted_count -eq 0 ]; then
        echo "Файлы для удаления не найдены"
    else
        echo "Удалено файлов: $deleted_count"
    fi
}

# Функция для показа справки
show_help() {
    echo "Использование: $0 create N - создать N файлов"
    echo "              $0 delete   - удалить все .tmp файлы"
    echo "              $0 list     - показать существующие .tmp файлы"
    echo "              $0 clean    - удалить все .tmp файлы (аналог delete)"
}

# Функция для списка файлов
list_files() {
    echo "Существующие .tmp файлы:"
    local found=0
    
    for file in *.tmp; do
        if [ -f "$file" ]; then
            echo "  $file"
            found=1
        fi
    done
    
    if [ $found -eq 0 ]; then
        echo "  Файлы не найдены"
    fi
}

# Основная логика скрипта
if [ $# -eq 0 ]; then
    show_help
    exit 1
fi

case "$1" in
    create)
        if [ $# -ne 2 ]; then
            echo "Ошибка: Укажите количество файлов для создания"
            echo "Использование: $0 create N"
            exit 1
        fi
        
        if ! [[ "$2" =~ ^[0-9]+$ ]] || [ "$2" -le 0 ]; then
            echo "Ошибка: Укажите положительное целое число"
            exit 1
        fi
        
        create_files "$2"
        ;;
        
    delete|clean)
        delete_files
        ;;
        
    list)
        list_files
        ;;
        
    -h|--help|help)
        show_help
        ;;
        
    *)
        echo "Неизвестная команда: $1"
        show_help
        exit 1
        ;;
esac
