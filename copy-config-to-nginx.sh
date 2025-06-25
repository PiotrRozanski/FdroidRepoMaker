#!/bin/bash

# Nazwa kontenera nginx (zgodnie z docker-compose.yml)
CONTAINER_NAME=fdroid-nginx

# Ścieżka do pliku w kontenerze
FILE_PATH=/usr/share/nginx/html/fdroid/config.yml

# Tekst do znalezienia (może być z komentarzem lub bez)
SEARCH_TEXT="# repo_name: My First F-Droid Repo Demo"
REPLACE_TEXT="repo_name: Apator Rector sp. z.o.o"

# Użyj sed do podmiany tekstu w pliku w kontenerze
docker exec $CONTAINER_NAME sed -i "s|$SEARCH_TEXT|$REPLACE_TEXT|g" $FILE_PATH

echo "Podmiana tekstu zakończona w $FILE_PATH w kontenerze $CONTAINER_NAME"
