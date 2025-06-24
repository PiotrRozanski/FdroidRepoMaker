FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git python3 python3-pip python3-venv openjdk-17-jdk-headless && \
    python3 -m venv /opt/fdroid-venv && \
    /opt/fdroid-venv/bin/pip install --upgrade pip && \
    /opt/fdroid-venv/bin/pip install fdroidserver && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV PATH="/opt/fdroid-venv/bin:$PATH"

WORKDIR /fdroid/repo

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

VOLUME ["/fdroid/repo"]

ENTRYPOINT ["/entrypoint.sh"]
