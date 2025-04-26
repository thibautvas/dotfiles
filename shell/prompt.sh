set_custom_prompt() {
  # exit status
  if [[ $? -eq 0 ]]; then # previous command success
    local user_color=$(eval "echo \$$HOST_COLOR")
  else # previous command failure
    local user_color="$RED"
  fi
  local active_user="[$USER@$(uname -n)]"

  # active directory
  local project branch active_dir dir_color
  if project=$(git rev-parse --show-toplevel 2>/dev/null); then
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    active_dir="$(basename "$project"):$branch $(echo "$PWD" | sed "s|^$project|~|")"
    dir_color="$YELLOW"
  else
    active_dir=$(echo "$PWD" | sed "s|^$HOME|~|")
    dir_color="$BLUE"
  fi

  if [[ -n "$name" ]]; then
    local active_shell="($name) "
  fi
  if [[ -n "$VIRTUAL_ENV" ]]; then
    local active_venv="($(basename $VIRTUAL_ENV)) "
  fi

  # render prompt
  PS1="$active_shell$active_venv$user_color$active_user $dir_color$active_dir\$ $DEFAULT"
}

if [[ -n "$BASH_VERSION" ]]; then
  DEFAULT='\[\e[0m\]'; RED='\[\e[31m\]'; GREEN='\[\e[32m\]'; YELLOW='\[\e[33m\]'; BLUE='\[\e[34m\]'; MAGENTA='\[\e[35m\]'; CYAN='\[\e[36m\]'
  PROMPT_COMMAND='set_custom_prompt'
elif [[ -n "$ZSH_VERSION" ]]; then
  DEFAULT='%f'; RED='%F{red}'; GREEN='%F{green}'; YELLOW='%F{yellow}'; BLUE='%F{blue}'; MAGENTA='%F{magenta}'; CYAN='%F{cyan}'
  precmd_functions+=('set_custom_prompt')
fi
