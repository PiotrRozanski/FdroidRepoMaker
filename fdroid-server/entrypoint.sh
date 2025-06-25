#!/bin/bash
set -e

# Sprawdź, czy repozytorium już istnieje (katalog metadata)
if [ ! -d "metadata" ]; then
  echo "[INFO] Inicjalizuję repozytorium F-Droid..."
  fdroid init
  fdroid update
else
  echo "[INFO] Repozytorium F-Droid już zainicjalizowane, pomijam init i update."
fi

# Utrzymywanie kontenera aktywnym
tail -f /dev/null
