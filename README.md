# dotfiles

Hi! I use this configuration on my local machine (macOS), as well as on remote machines (linux).

I typically clone this repository in `~/repos/git/dotfiles`, and symlink most of it to `~/.config` (cf. [`./recovery/darwin_init.sh`](recovery/darwin_init.sh)).

## Common configuration

Whenever possible, this configuration is shared between local and remote machines to streamline processes and avoid overhead.

## Shell configuration

I work on macOS and use the default z-shell locally.
As a matter of fact, I tend to use the default shell on any machine I connect to, to avoid wasting time on configuration.
That is why this repository contains a [`./shell/shellrc`](shell/shellrc) file, that I would symlink as `~/.bashrc` or `~/.zshrc`.

## Project structure

```bash
.
├── .gitignore
├── README.md
├── aerospace
│   ├── aerospace.toml
│   └── bin
│       ├── move_arc
│       ├── restart_aerospace
│       └── tmux_session_selector
├── code
│   ├── keybindings.json
│   └── settings.json
├── ghostty
│   └── config
├── git
│   ├── config
│   └── ignore
├── kmonad
│   └── home_row_mods.kbd
├── nvim
│   ├── init.lua
│   └── lua
│       └── default
│           ├── init.lua
│           ├── keymaps.lua
│           ├── lazy.lua
│           ├── options.lua
│           └── plugins
│               ├── catppuccin.lua
│               ├── completion.lua
│               ├── gitsigns.lua
│               ├── init.lua
│               ├── lspconfig.lua
│               ├── telescope.lua
│               └── treesitter.lua
├── recovery
│   ├── code_init.sh
│   └── darwin_init.sh
├── shell
│   ├── generic.sh
│   ├── gitflow.sh
│   ├── prompt.sh
│   └── shellrc
└── tmux
    ├── bin
    │   ├── attach_session
    │   ├── bind_j
    │   └── new_session
    └── tmux.conf

15 directories, 34 files
```
