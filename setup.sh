#!/usr/bin/env bash

set -euo pipefail

# set NOBIN to skip installation of following binaries in PATH
# set NOVIM to skip installation of nvim and plugins altogether
FZF_VERSION="0.67.0"
FD_VERSION="10.3.0"
RG_VERSION="15.1.0"
NVIM_VERSION="0.11.5"

TMPDIR=$(mktemp -d)

# dotfiles proper
mkdir -p "$HOME/.config"
curl -fsSL "https://github.com/thibautvas/dotfiles/archive/refs/heads/main.tar.gz" | tar -xz -C "$TMPDIR"

for dir in bash git nvim; do
  cp -r "$TMPDIR/dotfiles-main/$dir" "$HOME/.config"
done
ln -sf ".config/bash/bashrc" "$HOME/.bashrc"

# local binaries
if [[ -z "${NOBIN+x}" ]]; then
  mkdir -p "$HOME/.local/bin"
  for url in "junegunn/fzf/releases/download/v${FZF_VERSION}/fzf-${FZF_VERSION}-linux_amd64.tar.gz" \
             "sharkdp/fd/releases/download/v${FD_VERSION}/fd-v${FD_VERSION}-x86_64-unknown-linux-gnu.tar.gz" \
             "burntsushi/ripgrep/releases/download/${RG_VERSION}/ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl.tar.gz"
  do
    curl -fsSL "https://github.com/$url" | tar -xz -C "$TMPDIR"
  done

  for bin in fzf fd rg; do
    find "$TMPDIR" -type f -name "$bin" -executable -exec cp {} "$HOME/.local/bin" \;
  done
fi

# nvim and plugins
if [[ -z "${NOVIM+x}" ]]; then
  mkdir -p "$HOME/.local/share/nvim/site/pack/core/start"
  curl -fsSL "https://github.com/jqlang/jq/releases/latest/download/jq-linux-amd64" |
    install -m 755 /dev/stdin "$TMPDIR/jq"

  "$TMPDIR/jq" -r '.plugins[] | "\(.src) \(.rev)"' "$HOME/.config/nvim/nvim-pack-lock.json" |
    while read -r src rev; do
      curl -fsSL "$src/archive/$rev.tar.gz" | tar -xz -C "$HOME/.local/share/nvim/site/pack/core/start"
    done

  if [[ -z "${NOBIN+x}" ]]; then
    mkdir -p "$HOME/.local/opt"
    curl -fsSL "https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim-linux-x86_64.tar.gz" |
      tar -xz -C "$HOME/.local/opt"
    ln -s "../opt/nvim-linux-x86_64/bin/nvim" "$HOME/.local/bin"
  fi
fi
