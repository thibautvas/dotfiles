# refresh config
[[ -n "$ZSH_VERSION" ]] && alias rf="source ${ZDOTDIR:-$HOME}/.zshrc" # refresh .zshrc
[[ -n "$BASH_VERSION" ]] && alias rf="source $HOME/.bashrc" # refresh .bashrc

# list contents
alias ls='ls --color=auto' # colors
alias la='ls -A' # include dotted items
alias l.='ls -d .*' # restrict to dotted items
alias ll='ls -l' # detailed list
alias lla='ls -lA' # detailed list, include dotted items
alias ll.='ls -l -d .*' # detailed list, restrict to dotted items

# tree format
alias tree='tree -C' # colors
ts() {
  tree -L "${1:-1}" # $1 depth of tree, default 1
}
ta() {
  tree -aL "${1:-1}" # same
}

# search
alias grep='grep --color=auto' # colors

# move, copy, backup
alias mv='mv -iv' # confirmation prompt for overwriting destination, include verbose
alias cp='cp -iv' # same
bak() {
  cp -a "$1" "$1_$(date +%Y%m%d).bak"
}

# navigate
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ocd="cd $PWD" # cd directory in which shell was launched, or refreshed
alias cpt='alias ccd="cd $PWD"' # set ccd alias to cd cwd

# fuzzy
direct_cd() {
  local target
  if [[ -n "$2" ]]; then
    cd "$1/$2" 2>/dev/null && return 0
    target=$(
      fd --base-directory "$1" --type directory "^$2" --absolute-path |
      sed -n "${3:-1}p"
    )
  else
    target=$(
    { echo './'; fd --base-directory "$1" --type directory; } |
    awk -F '/' '{printf "%-20s # %s\n", $(NF-1), $0}' |
    fzf --reverse --height 10 --preview "tree -CaL 1 $1/{3}" |
    sed "s:^[^#]*# :$1/:"
    )
  fi
  [[ -n "$target" ]] && cd "$target"
}

alias dcd="direct_cd $RD"
alias wcd='direct_cd $PWD'
alias gcd='direct_cd "${$(git rev-parse --show-toplevel 2>/dev/null):-$RD/git}"'

# tmux
alias tns="$HOME/.config/tmux/bin/new_session"
alias tas="$HOME/.config/tmux/bin/attach_session"
alias tls='tmux list-sessions'
alias tks='tmux kill-session'

# neovim
vi() {
  if [[ -n "$1" ]]; then
    nvim "$1"
  else
    nvim +Telescope\ find_files
  fi
}

# vs code
co() {
  code "${1:-$PWD}" # default cwd
}

# virtual environments
alias va='source .venv/bin/activate'
alias da="deactivate"
alias van="source $RD/.vanilla/bin/activate" # setup-specific
alias choco="source $RD/.chocolate/bin/activate" # setup-specific

# shell counterpart to vs code's launch.json
run_module() {
  pkill -if "python -m $1.main --port 90${2:-70}" # kill existing process, if applicable
  if [[ $(git -C "$RD/git/$1" grep -q 'breakpoint()') ]]; then
    $RD/git/$1/.venv/bin/python -m $1.main --port 90${2:-70} # run module in the foreground
  else
    $RD/git/$1/.venv/bin/python -m $1.main --port 90${2:-70} & # run module in the background
  fi
}

alias rmh='run_module harmoney'
alias rmc='run_module checkmate'
alias rms='run_module sherlock'
