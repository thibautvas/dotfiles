# dotfiles

Notes:
  - As of March 2025 I am starting to transfer most of this configuration to [nix-config](https://github.com/thibautvas/nix-config).
  - I still use the [minimal](https://github.com/thibautvas/dotfiles/tree/minimal) version of these dotfiles on virtual machines that do not have nix.

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
│       ├── move_app
│       ├── restart_aerospace
│       ├── tmux_session_selector
│       └── toggle_menu_bar
├── code
│   ├── keybindings.json
│   └── settings.json
├── ghostty
│   └── config
├── git
│   ├── config
│   └── ignore
├── hypr
│   ├── bin
│   │   ├── battery
│   │   ├── bluetooth
│   │   ├── datetime
│   │   ├── launch
│   │   ├── launch_alt
│   │   └── wifi
│   ├── hypridle.conf
│   ├── hyprland.conf
│   ├── hyprlock.conf
│   └── hyprpaper.conf
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
│               ├── copilot.lua
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
    │   └── new_session
    └── tmux.conf

17 directories, 45 files
```
