# workflow
alias ga='git add --verbose'
alias gap='git add --patch'
alias gc='git commit'
alias gcm='git commit --message'
alias gam='git commit --amend'
alias gane='git commit --amend --no-edit'

# diff
alias gd='git diff'
alias gds='git diff --staged'
alias gdc='git diff HEAD~1 HEAD'

# undo
alias gr='git restore'
alias grp='git restore --patch'
alias gu='git restore --staged'
alias gup='git restore --staged --patch'

# status
alias gs='git -C "$(git rev-parse --show-toplevel)" status --short' # from toplevel
alias grs='git status --short .' # from cwd

# log
gl() { # readable log with length $1, default 5
  git log --graph --oneline --max-count=${1:-5} --pretty=format:'%C(auto)%h%Creset %cd %C(cyan)%an%Creset - %s%C(auto)%d%Creset' --date=format:'%Y-%m-%d %H:%M' HEAD
}

# checkout
gco() {
  local target
  if [[ -n "$1" ]]; then
    git checkout "$1" 2>/dev/null && return 0
    target=$(
      git for-each-ref --sort=-committerdate --format='%(refname:short)' refs/heads |
      grep -F "$1" |
      head -n 1
    )
  else
    target=$(
      git for-each-ref --sort=-committerdate --format='%(refname:short)' refs/heads |
      fzf --reverse --height 7 --preview \
        "git log --color=always --oneline --max-count=5 --pretty=format:'%C(cyan)%an%Creset - %s%C(auto)%d%Creset' {}"
    )
  fi
  [[ -n "$target" ]] && git checkout "$target"
}

# lazygit: https://github.com/jesseduffield/lazygit
alias lg='lazygit'
