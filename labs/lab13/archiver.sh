#!/bin/bash

# Покажем помощь если нужно
if [ "$1" = "--help" ] || [ "$1" = "-h" ] || [ $# -eq 0 ]; then
    echo "=== Архиватор файлов ==="
    echo ""
    echo "Использование:"
    echo "  $0 папка архив.tar.gz         - архивировать все файлы"
    echo "  $0 папка архив.tar.gz recent  - только файлы измененные за неделю"
    echo ""
    echo "Примеры:"
    echo "  $0 /home/user/docs backup.tar.gz"
    echo "  $0 ./my_folder backup.tar.gz recent"
    echo "  $0 --help                     - показать эту помощь"
    exit 0
fi

# Проверим количество аргументов
if [ $# -lt 2 ]; then
    echo "Ошибка: Недостаточно аргументов!"
    echo "Используйте: $0 папка архив.tar.gz"
    exit 1
fi

# Запомним аргументы
FOLDER="$1"
ARCHIVE="$2"
MODE="$3"

# Проверим существует ли папка
if [ ! -d "$FOLDER" ]; then
    echo "Ошибка: Папка '$FOLDER' не существует!"
    exit 1
fi

# Проверим права на чтение
if [ ! -r "$FOLDER" ]; then
    echo "Ошибка: Нет прав на чтение папки '$FOLDER'!"
    exit 1
fi

# Удалим старый архив если есть
if [ -f "$ARCHIVE" ]; then
    echo "Удаляем старый архив..."
    rm "$ARCHIVE"
fi

# Выберем режим работы
echo "=== Начинаем архивацию ==="
echo "Папка: $FOLDER"
echo "Архив: $ARCHIVE"

if [ "$MODE" = "recent" ]; then
    echo "Режим: только файлы измененные за неделю"
    echo ""
    
    # Создаем временный файл для списка
    TEMP_FILE=$(mktemp)
    
    # Ищем файлы измененные за последние 7 дней
    find "$FOLDER" -type f -mtime -7 > "$TEMP_FILE"
    
    # Проверяем нашли ли файлы
    FILE_COUNT=$(wc -l < "$TEMP_FILE")
    if [ "$FILE_COUNT" -eq 0 ]; then
        echo "Не найдено файлов измененных за последнюю неделю!"
        rm "$TEMP_FILE"
        exit 0
    fi
    
    echo "Найдено файлов: $FILE_COUNT"
    
    # Архивируем найденные файлы
    if tar -czf "$ARCHIVE" -C "$FOLDER" -T <(sed "s|^$FOLDER/||" "$TEMP_FILE"); then
        echo "✅ Успешно создан архив recent файлов!"
    else
        echo "❌ Ошибка при создании архива!"
        rm "$TEMP_FILE"
        exit 1
    fi
    
    # Удаляем временный файл
    rm "$TEMP_FILE"
    
else
    echo "Режим: все файлы"
    echo ""
    
    # Архивируем всю папку
    if tar -czf "$ARCHIVE" -C "$FOLDER" .; then
        echo "✅ Успешно создан архив всех файлов!"
    else
        echo "❌ Ошибка при создании архива!"
        exit 1
    fi
fi

# Покажем информацию о архиве
echo ""
echo "=== Результат ==="
echo "Архив: $ARCHIVE"
echo "Размер: $(du -h "$ARCHIVE" | cut -f1)"

# Посчитаем количество файлов в архиве
FILE_COUNT_IN_ARCHIVE=$(tar -tzf "$ARCHIVE" | wc -l)
echo "Файлов в архиве: $FILE_COUNT_IN_ARCHIVE"

echo ""
echo "🎉 Архивация завершена успешно!"
