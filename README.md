# dotfiles

Notes:
  - As of March 2025 I am starting to transfer most of this configuration to [nix-config](https://github.com/thibautvas/nix-config).
  - I still use the [minimal](https://github.com/thibautvas/dotfiles/tree/minimal) version of these dotfiles on virtual machines that do not have nix.

Hi! I use this configuration on my local machine (macos), as well as on remote machines (linux).

I typically clone this repository in `~/repos/git/dotfiles`, and symlink most of its contents to `~/.config`.

## Common configuration

Whenever possible, this configuration is shared between local and remote machines to streamline processes and avoid overhead.

## Shell configuration

I work on macos and use the default z-shell locally.
As a matter of fact, I tend to use the default shell on any machine I connect to, to avoid wasting time on configuration.
That is why this repository contains a [`./shell/shellrc`](shell/shellrc) file, that I would symlink as either `~/.bashrc` or `~/.zshrc`.

## Project structure

```text
.
├── .gitignore
├── README.md
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
├── shell
│   ├── aliases.sh
│   ├── prompt.sh
│   └── shellrc
└── tmux
    ├── bin
    │   └── tls
    └── tmux.conf

8 directories, 19 files
```
