# Enable colors
autoload -U colors && colors
setopt PROMPT_SUBST

# Function: show python environment name only
python_env() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    echo "%F{magenta}(venv:${VIRTUAL_ENV:t})%f"
  elif [[ -n "$CONDA_DEFAULT_ENV" ]]; then
    echo "%F{magenta}(conda:${CONDA_DEFAULT_ENV})%f"
  fi
}


# Function: data science indicator(SSH/WSL/DOCKER/JUPYTER/COLAB)
env_info() {
  ssh_info
  wsl_info
  docker_info
  jupyter_info
}

ssh_info() {
  if [[ -n "$SSH_CONNECTION" ]]; then
    echo "󰣀 "
  fi
}

wsl_info() {
  if grep -qi microsoft /proc/version 2>/dev/null; then
    echo " "
  fi
}

docker_info() {
  if [[ -f /.dockerenv ]] || grep -qa docker /proc/1/cgroup 2>/dev/null; then
    echo " "
  fi
}

jupyter_info() {
  if [[ -n "$JPY_PARENT_PID" ]] || [[ -n "$JUPYTERHUB_API_TOKEN" ]]; then
    echo " "
  fi
}

# Function: git branch and status
git_info() {
  local branch dirty icon sync stash ahead_behind stash_count behind ahead changed_count changed

  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null) || return 

  # Icon branch type
  if [[ "$branch" == "main" || "$branch" == "master" ]]; then
    icon=" "
  elif [[ "$branch" == dev* ]]; then
    icon=" "
  else
    icon=" "
  fi

  # File changes count and dirty repo 
  git_status=$(git status --porcelain 2>/dev/null)
  changed_count=$(echo "$git_status" | wc -l | tr -d ' ')

  if (( changed_count > 0 )); then
    dirty="%F{red}%f" # dirty repo
    changed="%F{red} $changed_count%f"
  else
    dirty="%F{green}%f" # clean repo
    changed=""
  fi

    # Ahead/Behind
    ahead_behind=$(git rev-list --left-right --count @{upstream}...HEAD 2>/dev/null)
    if [[ -n "$ahead_behind" ]]; then
      behind=${ahead_behind%%$'\t'*}
      ahead=${ahead_behind##*$'\t'}

      [[ "$ahead" -gt 0 ]] && sync+="%F{magenta} $ahead%f"
      [[ "$behind" -gt 0 ]] && sync+="%F{cyan} $behind%f"
    fi

    # Stash count
    stash_count=$(git stash list 2>/dev/null | wc -l | tr -d ' ' )
    [[ "$stash_count" -gt 0 ]] && stash="%F{blue} $stash_count%f"

    echo "%F{yellow}(${icon}${branch})%f ${dirty}${changed}${sync}${stash}"
}

# Function: show error code if last command failed
exit_code() {
  local code=$?
  if [[ $code -ne 0 ]]; then
    echo "%F{red}! $code%f "
  fi
}


# Function: Prompt color change
function zle-keymap-select {
  if [[ $KEYMAP == vicmd ]]; then
    PROMPT_ARROW="%F{red}%f"
  else
    PROMPT_ARROW="%F{green}%f"
  fi
  zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-init {
  PROMPT_ARROW="%F{green}%f"
}
zle -N zle-line-init

# Prompt
PROMPT=$'
%F{blue} %~%f
$(exit_code)%{${PROMPT_ARROW}%}  '
RPROMPT='$(env_info)$(python_env)$(git_info)'
