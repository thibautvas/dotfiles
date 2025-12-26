#!/bin/bash

mkdir -p "$HOME/.config"
mkdir -p "$HOME/.local/bin"
TMPDIR=$(mktemp -d)

ln -sf "$(realpath ./bash/bashrc)" "$HOME/.bashrc"
for dir in git bash nvim; do
  rm -rf "$HOME/.config/$dir"
  ln -s "$(realpath ./$dir)" "$HOME/.config"
done

fetch_tarball() {
    local name="$1"
    local url="$2"
    local extract_path="${3:-$(echo "$url" | sed 's#.*/\([^/]*\)\.tar\.gz#\1#')}/$name"
  curl -o "$TMPDIR/${name}.tar.gz" -fsSL "$url"
  tar -xzf "$TMPDIR/${name}.tar.gz" -C "$TMPDIR"
  cp "$TMPDIR/${extract_path}" "$HOME/.local/bin"
}

FD_VERSION="10.3.0"
FZF_VERSION="0.65.2"
RG_VERSION="14.1.1"

fetch_tarball fd https://github.com/sharkdp/fd/releases/download/v${FD_VERSION}/fd-v${FD_VERSION}-x86_64-unknown-linux-gnu.tar.gz
fetch_tarball fzf https://github.com/junegunn/fzf/releases/download/v${FZF_VERSION}/fzf-${FZF_VERSION}-linux_amd64.tar.gz .
fetch_tarball rg https://github.com/burntsushi/ripgrep/releases/download/${RG_VERSION}/ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl.tar.gz

rm -rf "$TMPDIR"
