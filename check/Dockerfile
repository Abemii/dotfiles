FROM ubuntu:22.04

RUN DEBIAN_FRONTEND=noninteractive \
    apt update && \
    apt install -y curl wget build-essential pkg-config unzip git file && \
    useradd -m -s /bin/bash user
# run neovim install script

WORKDIR /home/user
USER user
