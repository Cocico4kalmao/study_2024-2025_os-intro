#!/bin/bash

# Проверяем что указана команда
if [ $# -eq 0 ]; then
    echo "Ошибка: Не указана команда для поиска справки"
    echo "Использование: $0 имя_команды"
    echo "Пример: $0 ls"
    exit 1
fi

COMMAND_NAME="$1"
MAN_DIR="/usr/share/man/man1"
FOUND=0

echo "🔍 Поиск справки для команды: $COMMAND_NAME"

# Ищем файлы справки с разными вариантами имен
POSSIBLE_FILES=(
    "${COMMAND_NAME}.1.gz"
    "${COMMAND_NAME}.1"
    "${COMMAND_NAME}.gz"
    "${COMMAND_NAME}"
)

for file in "${POSSIBLE_FILES[@]}"; do
    MAN_FILE="${MAN_DIR}/${file}"
    
    if [ -f "$MAN_FILE" ]; then
        echo "✅ Найдена справка: $MAN_FILE"
        echo "================================================"
        
        # Показываем справку
        if [[ "$MAN_FILE" == *.gz ]]; then
            gunzip -c "$MAN_FILE" | less 2>/dev/null || gunzip -c "$MAN_FILE"
        else
            cat "$MAN_FILE" | less 2>/dev/null || cat "$MAN_FILE"
        fi
        
        FOUND=1
        break
    fi
done

# Если не нашли справку
if [ $FOUND -eq 0 ]; then
    echo "❌ Справка для команды '$COMMAND_NAME' не найдена"
    echo ""
    echo "Доступные команды в каталоге $MAN_DIR:"
    echo "----------------------------------------"
    
    # Покажем несколько доступных команд
    ls "$MAN_DIR" | head -10 | sed 's/\.gz$//' | sed 's/\.1$//'
    
    TOTAL_FILES=$(ls "$MAN_DIR" | wc -l)
    if [ $TOTAL_FILES -gt 10 ]; then
        echo "... и еще $(($TOTAL_FILES - 10)) команд"
    fi
    
    echo ""
    echo "Подсказка: попробуйте одну из этих команд"
    exit 1
fi

exit 0
