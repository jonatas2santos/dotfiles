# Enable colors
autoload -U colors && colors
setopt PROMPT_SUBST

# History
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.cache/zsh/zsh_history

# Enable Zsh completion system 
zmodload zsh/complist
autoload -Uz compinit
compinit
_comp_options+=(globdots) # include hidden files

# Menu style completion
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'

# Loads history search functions 
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
