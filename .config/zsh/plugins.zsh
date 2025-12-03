# Enable Zsh completion system 
zmodload zsh/complist
autoload -Uz compinit
compinit

# Menu style completion
zstyle ':completion:*' menu select

# Use vim motins in completion menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

