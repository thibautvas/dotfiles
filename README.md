# dotfiles

Notes:
  - As of March 2025 I am starting to transfer most of this configuration to [nix-config](https://github.com/thibautvas/nix-config).
  - I still use the [minimal](https://github.com/thibautvas/dotfiles/tree/minimal) version of these dotfiles on virtual machines that do not have nix.

Hi! I use this configuration on my local machine (macos), as well as on remote machines (linux).

I typically clone this repository in `~/repos/dotfiles` and run [`./setup.sh`](setup.sh) from there.

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
│   └── lua
│       └── default
│           ├── blink.lua
│           ├── catppuccin.lua
│           ├── fzf-lua.lua
│           ├── gitsigns.lua
│           ├── lsp.lua
│           ├── neogit.lua
│           ├── oil.lua
│           ├── settings.lua
│           └── treesitter.lua
├── setup.sh
└── tmux
    ├── bin
    │   └── tls
    └── tmux.conf

8 directories, 20 files
```
