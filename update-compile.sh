#!/bin/bash

clear

# Архив программы в текущей директории
if [ ! -f ./photoflare*.tar.gz ]; then
    echo "./photoflare*.tar.gz not found!"
    exit 1
fi

# Распаковка
tar -xvf photoflare*.tar.gz

# Находим каталог photoflare*
dir=$(find . -maxdepth 1 -type d -name "photoflare*" | head -n 1)

# Переходим и запускаем
if [ -n "$dir" ]; then
    cd "$dir"
# Обновить .ts (обязательно, синхронизация с кодом)
    lupdate ./Photoflare.pro

# Очистка несуществующих строк "obsolete" (могут пригодиться)
    lupdate -noobsolete ./Photoflare.pro

# Пересобрать .qm
    lrelease ./languages/*.ts
else
    echo "Error: Directory not found!"
    read a
fi
