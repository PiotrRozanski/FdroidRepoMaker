#!/bin/bash

# Nazwa kontenera nginx (zgodnie z docker-compose.yml)
NGINX_CONTAINER=fdroid-nginx

# Katalog z plikami APK na hoście
SOURCE_FOLDER=./apk

# Docelowy katalog w kontenerze nginx
DEST_FOLDER=/usr/share/nginx/html/fdroid/repo

# Poczekaj, aż kontener nginx będzie uruchomiony
while [ "$(docker inspect -f '{{.State.Running}}' $NGINX_CONTAINER 2>/dev/null)" != "true" ]; do
  echo "Czekam na uruchomienie kontenera $NGINX_CONTAINER..."
  sleep 1
done

# Skopiuj wszystkie pliki APK z hosta do kontenera
for apkfile in $SOURCE_FOLDER/*.apk; do
  if [ -f "$apkfile" ]; then
    echo "Kopiuję $apkfile do $NGINX_CONTAINER:$DEST_FOLDER"
    docker cp "$apkfile" "$NGINX_CONTAINER:$DEST_FOLDER"
  fi
done

echo "Wszystkie pliki APK zostały skopiowane."
