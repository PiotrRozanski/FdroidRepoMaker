#!/bin/bash
set -e

# Nazwy kontenerów i ścieżki
NGINX_CONTAINER=fdroid-nginx
NGINX_CONFIG_PATH=/usr/share/nginx/html/fdroid/config.yml
LOCAL_CONFIG=./fdroid-server/config.yml

# 1. Pobierz config.yml z kontenera nginx na hosta (tymczasowy plik)
docker cp $NGINX_CONTAINER:$NGINX_CONFIG_PATH ./nginx_config_tmp.yml

# 2. Wyciągnij wartości kluczy z pliku nginx_config_tmp.yml
extract_value() {
    grep -E "^$1:" ./nginx_config_tmp.yml | head -n1 | cut -d':' -f2- | sed 's/^ *//'
}

repo_keyalias_val=$(extract_value "repo_keyalias")
keystorepass_val=$(extract_value "keystorepass")
keypass_val=$(extract_value "keypass")
keydname_val=$(extract_value "keydname")

# 3. Podmień wartości w lokalnym config.yml
replace_or_add() {
    local key="$1"
    local value="$2"
    if grep -q "^$key:" "$LOCAL_CONFIG"; then
        sed -i "s|^$key:.*|$key: $value|" "$LOCAL_CONFIG"
    else
        echo "$key: $value" >> "$LOCAL_CONFIG"
    fi
}

replace_or_add "repo_keyalias" "$repo_keyalias_val"
replace_or_add "keystorepass" "$keystorepass_val"
replace_or_add "keypass" "$keypass_val"
replace_or_add "keydname" "$keydname_val"

# 4. Skopiuj zaktualizowany plik config.yml z powrotem do kontenera nginx
docker cp "$LOCAL_CONFIG" $NGINX_CONTAINER:$NGINX_CONFIG_PATH

# 5. Skopiuj pliki graficzne z hosta do kontenera nginx
ICON_SRC=./fdroid-server/repo-icon/icon.png
INDEX_SRC=./fdroid-server/repo-icon/index.png
ICON_DEST=/usr/share/nginx/html/fdroid/repo/icons/icon.png
INDEX_DEST=/usr/share/nginx/html/fdroid/repo/index.png

if [ -f "$ICON_SRC" ]; then
    docker cp "$ICON_SRC" $NGINX_CONTAINER:$ICON_DEST
    echo "Skopiowano $ICON_SRC do $NGINX_CONTAINER:$ICON_DEST"
else
    echo "Brak pliku $ICON_SRC, pomijam kopiowanie."
fi

if [ -f "$INDEX_SRC" ]; then
    docker cp "$INDEX_SRC" $NGINX_CONTAINER:$INDEX_DEST
    echo "Skopiowano $INDEX_SRC do $NGINX_CONTAINER:$INDEX_DEST"
else
    echo "Brak pliku $INDEX_SRC, pomijam kopiowanie."
fi


# 6. Posprzątaj tymczasowy plik
rm -f ./nginx_config_tmp.yml

echo "Podmieniono wartości w config.yml i zaktualizowano plik w kontenerze nginx."
