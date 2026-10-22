#!/usr/bin/env bash

if [ "$#" -ne 1 ] || [ ! -d "$1" ]; then
    echo "Użycie: $0 <ścieżka_do_katalogu>"
    exit 1
fi

tmp=$(mktemp) || exit 1
trap 'rm -f "$tmp"' EXIT

find "$1" -type f -exec cat {} + |
    tr ' ' '\n' |
    grep -v '^$' |
    sort -u > "$tmp"

while IFS= read -r slowo; do
    echo "$slowo:"
    grep -r -n -H -w -- "$slowo" "$1"
done < "$tmp"