# dotfiles

Notes:
  - As of March 2025 I am starting to transfer most of this configuration to [nix-config](https://github.com/thibautvas/nix-config).
  - I still use this minimal version of dotfiles on virtual machines that do not have nix.

I typically clone this repository in `~/repos/dotfiles` and run [`./setup.sh`](setup.sh) from there.

## Project structure

```text
.
├── .gitignore
├── README.md
├── bash
│   └── bashrc
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

6 directories, 17 files
```
