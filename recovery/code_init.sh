#!/bin/bash

# set config location (project code subdir)
config_loc="$(git -C "$(dirname "${BASH_SOURCE[0]}")" rev-parse --show-toplevel)/code"

# lauch vs code, exit on failure
/opt/homebrew/bin/code "$HOME" || exit 1

# install extensions
extensions=(
  'mskelton.one-dark-theme'
  'vscodevim.vim'
  'ms-vscode-remote.remote-ssh'
  'ms-python.python'
  'ms-python.vscode-pylance'
  'ms-python.debugpy'
  'ms-toolsai.jupyter'
  'ms-toolsai.jupyter-renderers'
  'charliermarsh.ruff'
  'mtxr.sqltools'
  'vertica-official.sqltools-vertica-driver'
  'github.copilot'
  'github.copilot-chat'
)

for extension in "${extensions[@]}"; do
  /opt/homebrew/bin/code --install-extension $extension
done

# remove unwanted dependencies
dependencies=(
  'ms-vscode.remote-explorer'
  'ms-vscode-remote.remote-ssh-edit'
  'ms-toolsai.jupyter-keymap'
  'ms-toolsai.vscode-jupyter-cell-tags'
  'ms-toolsai.vscode-jupyter-slideshow'
)

for dependency in "${dependencies[@]}"; do
  /opt/homebrew/bin/code --uninstall-extension $dependency
done

# symlink configuration files
config_items=(
  'keybindings.json'
  'settings.json'
  'snippets'
)

for config_item in "${config_items[@]}"; do
  if [[ -e "$config_loc/$config_item" ]]; then
    rm -rf "$HOME/Library/Application Support/Code/User/$config_item"
    ln -s "$config_loc/$config_item" "$HOME/Library/Application Support/Code/User"
  fi
done
