alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ocd="cd $PWD"
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias la='ls -Alt'
alias mv='mv -iv'
alias cp='cp -iv'
bak() {
  cp -a "$1" "$1_$(date +%Y%m%d).bak"
}

gs() {
  local root="${1:-$(git rev-parse --show-toplevel)}"
  git -C "$root" status --short .
}
gl() {
  git log --graph --oneline --max-count="${1:-5}" \
    --pretty=format:'%C(auto)%h%Creset %cd %C(cyan)%an%Creset - %s%C(auto)%d%Creset' \
    --date=format:'%Y-%m-%d %H:%M' HEAD
}
alias ga='git add --verbose'
alias gc='git commit'
alias gane='git commit --amend --no-edit'
alias gd='git diff'
alias gt='git difftool'
alias gr='git restore'
alias gu='git restore --staged'

gco() {
  git checkout "$1" 2>/dev/null && return 0
  local branches=$(git for-each-ref --sort=-committerdate --format='%(refname:short)' refs/heads)
  local target=$(
    [[ -n "$1" ]] && echo "$branches" | grep "^$1" | head -n1 ||
    echo "$branches" | fzf --reverse --height 7 --preview \
      "git log --color=always --oneline --max-count=5 \
      --pretty=format:'%C(cyan)%an%Creset - %s%C(auto)%d%Creset' {}"
  )
  git checkout "$target"
}

direct_cd() {
  local results=$(
    echo './'
    fd --base-directory "$1" --type directory "^$2"
  )
  local target=$(
    [[ -n "$2" ]] &&
    printf '%s\n' "$results" |
    fzf --filter="$2" |
    sed -n "${3:-1}p" ||
    echo "$results" |
    awk -F '/' '{printf "%-20s # %s\n", $(NF-1), $0}' |
    fzf --reverse --height 10 --preview "ls --color=always -1A $1/{3}" |
    sed 's/.* # //'
  )
  [[ -n "$target" ]] && cd "$1/$target"
}
alias dcd="direct_cd $HOST_PROJECT_DIR"
alias gcd='direct_cd "$(git rev-parse --show-toplevel 2>/dev/null || echo $HOST_PROJECT_DIR/git)"'

vi() {
  [[ -n "$1" ]] && nvim "$1" || nvim +"$PICKER_CMD"
}
