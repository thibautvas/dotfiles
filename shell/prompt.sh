set_custom_prompt() {
  [[ $? -eq 0 ]] &&
  local user_color=$(eval "echo \$$HOST_COLOR") ||
  local user_color="$RED"

  local active_user="[$USER@$(uname -n)]"

  local project
  project=$(git rev-parse --show-toplevel 2>/dev/null) && {
    local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    local active_dir="$(basename "$project"):$branch $(echo "$PWD" | sed "s:^$project:~:")"
    local dir_color="$YELLOW"
  } || {
    local active_dir=$(echo "$PWD" | sed "s:^$HOME:~:")
    local dir_color="$BLUE"
  }

  [[ -n "$name" ]] &&
  local active_shell="($name) " || {
    [[ $(echo $PATH | cut -d':' -f1) == /nix/store/* ]] &&
    local active_shell="($(echo $PATH | cut -d'-' -f2)-env) "
  }
  [[ -n "$VIRTUAL_ENV" ]] &&
  local active_venv="($(basename $VIRTUAL_ENV)) "

  PS1="$active_shell$active_venv$user_color$active_user $dir_color$active_dir\$ $DEFAULT"
}

if [[ -n "$BASH_VERSION" ]]; then
  DEFAULT='\[\e[0m\]'; RED='\[\e[31m\]'; GREEN='\[\e[32m\]'; YELLOW='\[\e[33m\]'; BLUE='\[\e[34m\]'; MAGENTA='\[\e[35m\]'; CYAN='\[\e[36m\]'
  PROMPT_COMMAND='set_custom_prompt'
elif [[ -n "$ZSH_VERSION" ]]; then
  DEFAULT='%f'; RED='%F{red}'; GREEN='%F{green}'; YELLOW='%F{yellow}'; BLUE='%F{blue}'; MAGENTA='%F{magenta}'; CYAN='%F{cyan}'
  precmd_functions+=('set_custom_prompt')
fi
