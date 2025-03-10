set_custom_prompt() {
  # exit status
  if [[ $? -eq 0 ]]; then # previous command success
    local prompt_color="$PROMPTCOLOR"
  else # previous command failure
    local prompt_color="${RED:-red}"
  fi

  # active directory
  local project branch active_dir dir_color
  if project=$(git rev-parse --show-toplevel 2>/dev/null); then
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    active_dir="${project##*/}:$branch ${PWD/$project/~}"
    dir_color="${YELLOW:-yellow}"
  else
    active_dir="${PWD/$HOME/~}"
    dir_color="${BLUE:-blue}"
  fi

  # render prompt
  [[ -n "$BASH_VERSION" ]] && PS1="${VIRTUAL_ENV+(${VIRTUAL_ENV##*/}) }$prompt_color[$USER@$(uname -n)] $dir_color$active_dir\$ $DEFAULT"
  [[ -n "$ZSH_VERSION" ]] && PS1="${VIRTUAL_ENV+(${VIRTUAL_ENV##*/}) }%F{$prompt_color}[$USER@$(uname -n)]%f %F{$dir_color}$active_dir\$%f "
}

if [[ -n "$BASH_VERSION" ]]; then
  DEFAULT='\[\e[0m\]'; RED='\[\e[31m\]'; GREEN='\[\e[32m\]'; YELLOW='\[\e[33m\]'; BLUE='\[\e[34m\]'; MAGENTA='\[\e[35m\]'; CYAN='\[\e[36m\]' ; PROMPTCOLOR=${!HOSTCOLOR}
  PROMPT_COMMAND='set_custom_prompt'
elif [[ -n "$ZSH_VERSION" ]]; then
  PROMPTCOLOR=$HOSTCOLOR
  precmd_functions+=('set_custom_prompt')
fi
