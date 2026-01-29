# dotfiles

Notes:
  - As of March 2025 I am starting to transfer most of this configuration to [nix-config](https://github.com/thibautvas/nix-config).
  - I still use these dotfiles on virtual machines that do not have nix.

I have switched to a remote installation of these dotfiles:
```bash
curl -fsSL https://raw.githubusercontent.com/thibautvas/dotfiles/refs/heads/main/setup.sh | bash
```

For development purposes, I also maintain a local installation setup via the [symlink](https://github.com/thibautvas/dotfiles/tree/symlink) branch:
```bash
curl -fsSL https://raw.githubusercontent.com/thibautvas/dotfiles/refs/heads/symlink/setup.sh | bash
```

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
