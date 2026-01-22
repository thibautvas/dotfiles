#!/usr/bin/env bash

set -euo pipefail

JQ_VERSION="1.8.1"
NVIM_VERSION="0.11.5"

LOCALBIN="$HOME/.local/bin"
LOCALOPT="$HOME/.local/opt"
NVIMSTART="$HOME/.local/share/nvim/site/pack/core/start"
mkdir -p "$LOCALBIN" "$LOCALOPT" "$NVIMSTART"
export PATH="$LOCALBIN:$PATH"

curl -fsSL "https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim-linux-x86_64.tar.gz" |
  tar -xz -C "$LOCALOPT"
ln -s "$LOCALOPT/nvim-linux-x86_64/bin/nvim" "$LOCALBIN"

curl -fsSL "https://github.com/jqlang/jq/releases/download/jq-${JQ_VERSION}/jq-linux-amd64" |
  install -m 755 /dev/stdin "$LOCALBIN/jq"

curl -fsSL "https://raw.githubusercontent.com/thibautvas/dotfiles/refs/heads/main/nvim/nvim-pack-lock.json" |
  jq -r '.plugins[] | "\(.src) \(.rev)"' |
  while read -r src rev; do
    curl -fsSL "$src/archive/$rev.tar.gz" | tar -xz -C "$NVIMSTART"
  done
