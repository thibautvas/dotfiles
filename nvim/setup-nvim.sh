#!/usr/bin/env bash

set -euo pipefail

LOCK_FILE="$(dirname ${BASH_SOURCE[0]})/nvim-pack-lock.json"
DEST="$HOME/.local/share/nvim/site/pack/core/start"
mkdir -p "$DEST"

jq -r '.plugins | to_entries[] | "\(.value.src) \(.value.rev)"' "$LOCK_FILE" | while read -r src rev; do
  curl -fsSL "$src/archive/$rev.tar.gz" | tar -xz -C "$DEST"
done
