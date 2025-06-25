set -e

# 1. Uruchom kontenery i poczekaj aż będą healthy
echo "[INFO] Uruchamiam kontenery i czekam aż będą gotowe..."
docker compose up -d --build --wait

# 2. Kopiowanie konfiguracji NGINX
echo "[INFO] Kopiuję konfigurację NGINX..."
chmod +x copy-config-to-nginx.sh
./copy-config-to-nginx.sh

# 3. Kopiowanie APK
echo "[INFO] Kopiuję APK do repozytorium..."
chmod +x copy-apk-to-repo.sh
./copy-apk-to-repo.sh

# 4. Wykonaj fdroid update w kontenerze fdroid-server
echo "[INFO] Wykonuję fdroid update w kontenerze fdroid-server..."
docker exec fdroid-server fdroid update

# 5. Logi z kontenera fdroid-server
echo "[INFO] Logi z kontenera fdroid-server:"
docker logs fdroid-server
