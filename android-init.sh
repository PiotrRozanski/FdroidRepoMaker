#!/bin/bash
set -e

# Dodaj cmdline-tools/latest/bin do PATH
export PATH=$PATH:/opt/android-sdk/cmdline-tools/tools/bin

# Instalacja wymaganych komponentów SDK
sdkmanager --update
sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0"

# Utrzymanie kontenera aktywnym
tail -f /dev/null
