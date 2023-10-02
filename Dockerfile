FROM python:3.10-slim-bullseye
# 复制 start.sh 到容器内
COPY start.sh /app/start.sh

ARG VERSION=v1.1.0
ARG BIN_LINK_AMD64=https://github.com/Mrs4s/go-cqhttp/releases/download/${VERSION}/go-cqhttp_linux_amd64.tar.gz
ARG BIN_LINK_ARM64=https://github.com/Mrs4s/go-cqhttp/releases/download/${VERSION}/go-cqhttp_linux_arm64.tar.gz
ARG TARGETARCH

ENV TZ Asia/Shanghai
ENV DEBIAN_FRONTEND=noninteractive
ARG BIN_LINK
WORKDIR /app

RUN apt-get update && \
    apt-get install -y curl tar yasm ffmpeg tzdata && \
    case ${TARGETARCH} in \
        "amd64") BIN_LINK=${BIN_LINK_AMD64} ;; \
        "arm64") BIN_LINK=${BIN_LINK_ARM64} ;; \
    esac && \
    curl -LJo /app/bin.tar.gz ${BIN_LINK} && \
    tar -zxvf bin.tar.gz && \
    chmod +x go-cqhttp

# Install haruka-bot
RUN pip install haruka-bot && \
    playwright install-deps && \
    pip cache purge && \
    rm -rf /var/lib/apt/lists/*

# Start haruka-bot
WORKDIR /haruka_bot
ENV TZ=Asia/Shanghai PLAYWRIGHT_BROWSERS_PATH=/ms-playwright LANG=zh_CN.UTF-8 HOST=0.0.0.0

# Start the custom startup script
CMD ["/bin/bash", "/app/start.sh"]

