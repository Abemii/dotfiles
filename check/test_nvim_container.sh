#!/usr/bin/env bash

set -eu

# コンテナ名とイメージ名
IMAGE_NAME=nvim-osc52
CONTAINER_NAME=nvim-osc52-test

# このスクリプトのある場所から dotfiles を相対参照
SCRIPT_DIR=$(dirname "$(realpath "$0")")
DOTFILES_DIR=$(realpath "${SCRIPT_DIR}/..")

# Docker イメージをビルド
docker build -t "${IMAGE_NAME}" -f "${SCRIPT_DIR}/Dockerfile" "${SCRIPT_DIR}"

# コンテナ起動（dotfiles をマウント）
docker run --rm -it \
  --name "${CONTAINER_NAME}" \
  -e USE_OSC52=true \
  -v "${DOTFILES_DIR}:/home/user/dotfiles" \
  "${IMAGE_NAME}" \
  /bin/bash
