#!/bin/bash

: <<prerequisites
OS: macOS
Homebrew: https://brew.sh
Personal config: https://github.com/thibautvas/dotfiles
prerequisites

# set config location (project toplevel)
config_loc=$(git -C "$(dirname "${BASH_SOURCE[0]}")" rev-parse --show-toplevel)

# check prerequisites, and exit if any are not met
[[ $(uname) != 'Darwin' ]] && echo 'Error: this script is meant to run on macOS' && exit 1
[[ -z $(command -v /opt/homebrew/bin/brew) ]] && echo 'Error: homebrew must be installed' && exit 1
[[ ! -d "$config_loc" ]] && echo 'Error: config repo not found' && exit 1

# symlink config to ~/.config
mkdir -p "$HOME/.config"
config_dirs=(
  "aerospace"
  "ghostty"
  "git"
  "nvim"
  "shell"
  "tmux"
)

for config_dir in "${config_dirs[@]}"; do
  [[ -d "$config_loc/$config_dir" ]] && ln -s "$config_loc/$config_dir" "$HOME/.config"
done

# symlink config to other locations
mkdir -p "$HOME/.ssh"
[[ -f "$config_loc/ssh/config" ]] && ln -s "$config_loc/ssh/config" "$HOME/.ssh"
[[ -f "$config_loc/shell/shellrc" ]] && ln -s "$config_loc/shell/shellrc" "$HOME/.zshrc"

# homebrew packages
formulae=(
  "fd"
  "fzf"
  "lazygit"
  "neovim"
  "node"
  "pyright"
  "python@3.9"
  "python@3.11"
  "ripgrep"
  "tmux"
  "tree"
)

casks=(
  "nikitabobko/tap/aerospace"
  "arc"
  "ghostty"
  "visual-studio-code"
)

brew install ${formulae[@]}
brew install --cask ${casks[@]}

# execute VS Code init script (extensions and symlink config)
$config_loc/recovery/code_init.sh
