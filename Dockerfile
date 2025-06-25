FROM thyrlian/android-sdk:latest

RUN mkdir -p /opt/android-sdk

COPY android-init.sh /android-init.sh

ENV ANDROID_HOME=/opt/android-sdk
ENV ANDROID_SDK_ROOT=/opt/android-sdk

RUN chmod +x /android-init.sh

ENTRYPOINT ["/bin/bash", "/android-init.sh"]
