#!/usr/bin/env bash

set -euo pipefail

# set NODOT to skip installation of dotfiles
# set NOBIN to skip installation of following binaries in PATH
# set NOVIM to skip installation of nvim and plugins altogether
FZF_VERSION="0.72.0"
FD_VERSION="10.4.2"
RG_VERSION="15.1.0"
NVIM_VERSION="0.12.4"

fetch() {
  echo "==> Downloading: $1" >&2
  curl -fL "$1"
}

TMPDIR=$(mktemp -d)
fetch "https://github.com/thibautvas/dotfiles/archive/refs/heads/main.tar.gz" | tar -xz -C "$TMPDIR"

# dotfiles proper
if [[ -z "${NODOT+x}" ]]; then
  mkdir -p "$HOME/.config"
  for dir in bash git nvim; do
    cp -r "$TMPDIR/dotfiles-main/$dir" "$HOME/.config"
  done
  ln -sf ".config/bash/bashrc" "$HOME/.bashrc"
fi

# local binaries
if [[ -z "${NOBIN+x}" ]]; then
  mkdir -p "$HOME/.local/bin"
  for url in "junegunn/fzf/releases/download/v${FZF_VERSION}/fzf-${FZF_VERSION}-linux_amd64.tar.gz" \
             "sharkdp/fd/releases/download/v${FD_VERSION}/fd-v${FD_VERSION}-x86_64-unknown-linux-gnu.tar.gz" \
             "burntsushi/ripgrep/releases/download/${RG_VERSION}/ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl.tar.gz"
  do
    fetch "https://github.com/$url" | tar -xz -C "$TMPDIR"
  done

  for bin in fzf fd rg; do
    find "$TMPDIR" -type f -name "$bin" -executable -exec cp {} "$HOME/.local/bin" \;
  done
fi

# nvim and plugins
if [[ -z "${NOVIM+x}" ]]; then
  mkdir -p "$HOME/.local/share/nvim/site/pack/core/start"
  fetch "https://github.com/jqlang/jq/releases/latest/download/jq-linux-amd64" |
    install -m 755 /dev/stdin "$TMPDIR/jq"

  "$TMPDIR/jq" -r '.plugins[] | "\(.src) \(.rev)"' "$TMPDIR/dotfiles-main/nvim/nvim-pack-lock.json" |
    while read -r src rev; do
      fetch "$src/archive/$rev.tar.gz" | tar -xz -C "$HOME/.local/share/nvim/site/pack/core/start"
    done

  if [[ -z "${NOBIN+x}" ]]; then
    mkdir -p "$HOME/.local/opt"
    fetch "https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim-linux-x86_64.tar.gz" |
      tar -xz -C "$HOME/.local/opt"
    ln -s "../opt/nvim-linux-x86_64/bin/nvim" "$HOME/.local/bin"
  fi
fi
