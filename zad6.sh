#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
    echo "Użycie: $0 <ścieżka_do_katalogu>"
    exit 1
fi

if [ ! -d "$1" ]; then
    echo "Błąd: podana ścieżka nie jest katalogiem."
    exit 1
fi

find "$1" -type f -exec awk '
{
    n = split($0, slowa, /[[:space:]]+/)
    delete licznik

    for (i = 1; i <= n; i++) {
        if (slowa[i] != "")
            licznik[slowa[i]]++
    }

    for (slowo in licznik) {
        if (licznik[slowo] > 1) {
            print FILENAME ":" FNR ":" $0
            break
        }
    }
}
' {} +