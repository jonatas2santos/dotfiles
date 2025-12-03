# Use vim mode in Zsh
bindkey -v

# Loads history search functions 
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# up/down keys use smart history search
[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

# CTRL + j/k use smart history search with vim motions 
bindkey '^k' up-line-or-beginning-search
bindkey '^j' down-line-or-beginning-search

# j/k use smart history search with vim motions in normal mode
bindkey -M vicmd 'k' up-line-or-beginning-search
bindkey -M vicmd 'j' down-line-or-beginning-search

# Exit insert mode
bindkey -M viins 'jk' vi-cmd-mode
