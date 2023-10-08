FROM python:3.10-slim-bullseye

# 复制 start.sh 到容器内
COPY start.sh /app/start.sh
# 复制字体文件
COPY HarmonyOS_Sans_Black.ttf /usr/share/fonts/

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

WORKDIR /cqdata
RUN /app/go-cqhttp faststart
