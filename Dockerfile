FROM thyrlian/android-sdk:latest

# Utwórz katalog na SDK (jeśli nie istnieje)
RUN mkdir -p /opt/android-sdk

# Skopiuj skrypt inicjalizacyjny do obrazu
COPY android-init.sh /android-init.sh

# Ustaw zmienne środowiskowe
ENV ANDROID_HOME=/opt/android-sdk
ENV ANDROID_SDK_ROOT=/opt/android-sdk

# Ustaw uprawnienia do uruchamiania skryptu
RUN chmod +x /android-init.sh

# Ustaw polecenie startowe
ENTRYPOINT ["/bin/bash", "/android-init.sh"]
