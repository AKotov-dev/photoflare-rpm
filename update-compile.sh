#!/bin/bash

clear

ARCHIVE=$(ls ./photoflare*.tar.gz 2>/dev/null | head -n1)

if [ -z "$ARCHIVE" ]; then
    echo "Error: photoflare archive not found!"
    read a
    exit 1
fi

echo "Archive: $ARCHIVE"

# Определяем имя каталога из архива
DIR=$(tar -tf "$ARCHIVE" | head -n1 | cut -d/ -f1)

if [ -z "$DIR" ]; then
    echo "Error: unable to determine source directory!"
    read a
    exit 1
fi

# Удаляем старую распаковку
rm -rf "./$DIR"

# Распаковка
tar -xvf "$ARCHIVE"

# Проверка
if [ ! -d "./$DIR" ]; then
    echo "Error: source directory not found after unpack!"
    read a
    exit 1
fi

cd "./$DIR" || exit 1

echo
echo "=== Updating TS files ==="
lupdate ./Photoflare.pro

echo
echo "=== Building QM files ==="
lrelease ./languages/*.ts

echo
echo "Done."

exit 0
