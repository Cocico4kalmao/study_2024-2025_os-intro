#!/bin/bash

# Время ожидания и использования ресурса
WAIT_TIME=${1:-3}  # t1 - время ожидания (по умолчанию 3 сек)
USE_TIME=${2:-5}   # t2 - время использования (по умолчанию 5 сек)
SEM_FILE="/tmp/resource.sem"

echo "Процесс $$: Запущен с WAIT_TIME=$WAIT_TIME, USE_TIME=$USE_TIME"

# Функция ожидания ресурса
wait_for_resource() {
    local waited=0
    echo "Процесс $$: Ожидаю освобождения ресурса..."
    
    while [ $waited -lt $WAIT_TIME ]; do
        if [ ! -f "$SEM_FILE" ]; then
            echo "Процесс $$: Ресурс свободен! Занимаю..."
            touch "$SEM_FILE"
            echo "$$" > "$SEM_FILE"
            return 0
        fi
        
        echo "Процесс $$: Ресурс занят процессом $(cat "$SEM_FILE" 2>/dev/null || echo 'unknown'), жду..."
        sleep 1
        waited=$((waited + 1))
    done
    
    echo "Процесс $$: Таймаут ожидания! Ресурс не освободился."
    return 1
}

# Функция использования ресурса
use_resource() {
    echo "Процесс $$: Использую ресурс в течение $USE_TIME секунд..."
    local used=0
    
    while [ $used -lt $USE_TIME ]; do
        echo "Процесс $$: Работаю с ресурсом... ($((used + 1))/$USE_TIME)"
        sleep 1
        used=$((used + 1))
        
        # Проверяем что мы еще владеем ресурсом
        if [ ! -f "$SEM_FILE" ] || [ "$(cat "$SEM_FILE" 2>/dev/null)" != "$$" ]; then
            echo "Процесс $$: Ресурс был забран другим процессом!"
            return 1
        fi
    done
    
    echo "Процесс $$: Завершил использование ресурса"
}

# Функция освобождения ресурса
release_resource() {
    if [ -f "$SEM_FILE" ] && [ "$(cat "$SEM_FILE" 2>/dev/null)" = "$$" ]; then
        rm -f "$SEM_FILE"
        echo "Процесс $$: Освободил ресурс"
    fi
}

# Основная логика
if wait_for_resource; then
    use_resource
    release_resource
else
    echo "Процесс $$: Не удалось получить ресурс"
fi

echo "Процесс $$: Завершен"
