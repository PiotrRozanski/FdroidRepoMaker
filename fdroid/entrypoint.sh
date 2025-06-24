#!/bin/bash
set -e

# Inicjalizacja repozytorium, jeśli nie istnieje
fdroid init || echo "fdroid init zakończony błędem, prawdopodobnie repozytorium już istnieje."

# Aktualizacja repozytorium (np. po wrzuceniu nowych APK)
fdroid update

# Utrzymywanie kontenera aktywnym
tail -f /dev/null
