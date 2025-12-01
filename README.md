# dotfiles

2025 rewrite:
  - These dotfiles have been made minimal by design, they only configure a shell, a vcs, and an editor.
  - See [nix-config](https://github.com/thibautvas/nix-config) for other config files.

## Project structure

```text
.
├── .gitignore
├── README.md
├── bash
│   ├── aliases
│   ├── bashrc
│   └── prompt
├── git
│   ├── config
│   └── ignore
├── nvim
│   ├── init.lua
│   ├── lua
│   │   └── default
│   │       ├── blink.lua
│   │       ├── catppuccin.lua
│   │       ├── fzf-lua.lua
│   │       ├── gitsigns.lua
│   │       ├── lsp.lua
│   │       ├── neogit.lua
│   │       ├── oil.lua
│   │       ├── settings.lua
│   │       └── treesitter.lua
│   └── nvim-pack-lock.json
└── setup.sh

6 directories, 19 files
```
