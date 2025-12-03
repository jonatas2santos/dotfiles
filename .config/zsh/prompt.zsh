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

# Function: git branch and status
git_info() {
  local branch dirty

  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [[ -n "$branch" ]]; then
    if [[ -n "$(git status --porcelain 2>/dev/null)" ]]; then
      dirty="%F{red}%f" # dirty repo
    else
      dirty="%F{green}%f" # clean repo
    fi
    echo "%F{yellow}(${branch})%f ${dirty}"
  fi
}

# Function: show error code if last command failed
exit_code() {
  local code=$?
  if [[ $code -ne 0 ]]; then
    echo "%F{red}! $code%f "
  fi
}

# Function: data science indicator
ds_info() {
  if [[ -f "requirements.txt" ]] && grep -qiE "numpy|pandas|matplotlib|scikit-learn" requirements.txt; then
    echo "%F{cyan} DS%f"
  elif [[ -f "pyproject.toml" ]] && grep -qiE "numpy|pandas|matplotlib|scikit-learn" pyproject.toml; then
    echo "%F{cyan} DS%f"
  elif [[ -n *.ipynb(#qN) ]]; then
    echo "%F{cyan} Notebook%f"
  fi
}

# Function: Prompt color change
function zle-keymap-select {
  if [[ $KEYMAP == vicmd ]]; then
    PROMPT_ARROW="%F{red}%f"
  else
    PROMPT_ARROW="%F{green}%f"
  fi
  zle reset-prompt
}
zle -N zle-keymap-select
PROMPT_ARROW="%F{green}%f"

# Prompt
PROMPT=$'
%F{blue}%{%} %~ 
$(exit_code)%{${PROMPT_ARROW}%}  '
RPROMPT='$(python_env)$(ds_info)$(git_info)%F{cyan}%{%} %*'
