# dotfiles

2025 rewrite:
  - These dotfiles have been made minimal by design, they only configure a shell, a vcs, and an editor.
  - See [nix-config](https://github.com/thibautvas/nix-config) for other config files.
  - [init.lua](nvim/init.lua) and [bashrc](bash/bashrc) serve as inputs to
    [nix-config](https://github.com/thibautvas/nix-config) to avoid duplicating maintainance efforts.


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
│   └── nvim-pack-lock.json
└── setup.sh

4 directories, 8 files
```
