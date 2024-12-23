set_custom_prompt() {
  local exit_status=$? # previous command exit status

  # active environment
  local active_env
  if [[ -n "$VIRTUAL_ENV" ]]; then
    active_env="(${VIRTUAL_ENV##*/})"
  elif [[ -z "$SSH_CLIENT" ]]; then
    active_env=$'\u2192'
  else
    active_env=$'\u2133'
  fi

  # environment color
  local env_color
  if [[ $exit_status -eq 0 && -z "$SSH_CLIENT" ]]; then # previous command success and local machine
    env_color="${GREEN:-green}"
  elif [[ $exit_status -eq 0 && -n "$SSH_CLIENT" ]]; then # previous command success and remote
    env_color="${MAGENTA:-magenta}"
  else # previous command failure
    env_color="${RED:-red}"
  fi

  # active directory and color
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
  [[ -n "$BASH_VERSION" ]] && PS1="$env_color$active_env $dir_color$active_dir\$ $DEFAULT"
  [[ -n "$ZSH_VERSION" ]] && PS1="%F{$env_color}$active_env%f %F{$dir_color}$active_dir\$%f "
}

if [[ -n "$BASH_VERSION" ]]; then
  DEFAULT='\[\e[0m\]'; RED='\[\e[31m\]'; GREEN='\[\e[32m\]'; YELLOW='\[\e[33m\]'; BLUE='\[\e[34m\]'; MAGENTA='\[\e[35m\]'; CYAN='\[\e[36m\]'
  PROMPT_COMMAND='set_custom_prompt'
elif [[ -n "$ZSH_VERSION" ]]; then
  precmd_functions+=('set_custom_prompt')
fi
