#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
    echo "Użycie: $0 <ścieżka_do_katalogu>"
    exit 1
fi

if [ ! -d "$1" ]; then
    echo "Błąd: podana ścieżka nie jest katalogiem."
    exit 1
fi

find "$1" -type f -exec sh -c '
    for file do
        tr " " "\n" < "$file" |
        grep -v "^$" |
        sort -u
    done
' sh {} \; |
sort |
uniq -c