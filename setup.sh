#!/bin/bash

set -e

mkdir -p "$HOME/.config"
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/opt"
TMPDIR=$(mktemp -d)

ln -sf "$(realpath ./bash/bashrc)" "$HOME/.bashrc"
for dir in git nvim; do
  rm -rf "$HOME/.config/$dir"
  ln -s "$(realpath ./$dir)" "$HOME/.config"
done

fetch_tarball() {
  local name="$1"
  local url="$2"
  local extract_dir="${3:-$TMPDIR}"
  curl -fsSL "$url" -o "$extract_dir/${name}.tar.gz"
  tar -xzf "$extract_dir/${name}.tar.gz" -C "$extract_dir"
  find "$extract_dir" -type f -name "$name" -executable -exec cp {} "$HOME/.local/bin" \;
}

FD_VERSION="10.3.0"
FZF_VERSION="0.65.2"
RG_VERSION="14.1.1"
NVIM_VERSION="nightly"

fetch_tarball fd https://github.com/sharkdp/fd/releases/download/v${FD_VERSION}/fd-v${FD_VERSION}-x86_64-unknown-linux-gnu.tar.gz
fetch_tarball fzf https://github.com/junegunn/fzf/releases/download/v${FZF_VERSION}/fzf-${FZF_VERSION}-linux_amd64.tar.gz
fetch_tarball rg https://github.com/burntsushi/ripgrep/releases/download/${RG_VERSION}/ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl.tar.gz

fetch_tarball nvim https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-x86_64.tar.gz "$HOME/.local/opt"
ln -sf "$HOME/.local/opt/nvim-linux-x86_64/bin/nvim" "$HOME/.local/bin"
