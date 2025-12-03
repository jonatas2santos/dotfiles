# Zsh config folder
ZSH_CONFIG_FOLDER="$HOME/.config/zsh"

mkdir -p "$ZSH_CONFIG_FOLDER"
for file in prompt.zsh aliases.zsh exports.zsh functions.zsh plugins.zsh keybinds.zsh; do
  [ ! -f "$ZSH_CONFIG_FOLDER/$file" ] && touch "$ZSH_CONFIG_FOLDER/$file"
done

# Load config files
[ -f "$ZSH_CONFIG_FOLDER/prompt.zsh" ] && source "$ZSH_CONFIG_FOLDER/prompt.zsh"
[ -f "$ZSH_CONFIG_FOLDER/exports.zsh" ] && source "$ZSH_CONFIG_FOLDER/exports.zsh"
[ -f "$ZSH_CONFIG_FOLDER/aliases.zsh" ] && source "$ZSH_CONFIG_FOLDER/aliases.zsh"
[ -f "$ZSH_CONFIG_FOLDER/functions.zsh" ] && source "$ZSH_CONFIG_FOLDER/functions.zsh"
[ -f "$ZSH_CONFIG_FOLDER/plugins.zsh" ] && source "$ZSH_CONFIG_FOLDER/plugins.zsh"
[ -f "$ZSH_CONFIG_FOLDER/keybinds.zsh" ] && source "$ZSH_CONFIG_FOLDER/keybinds.zsh"
