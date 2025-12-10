# Use vim mode in Zsh
bindkey -v

# Edit the current command in Neovim with Ctrl+e, execute with F5
function zle-nvim-edit {
  emulate -L zsh
  setopt localoptions pipefail

  # create a temp file with correct permissions
  local tmpfile
  tmpfile=$(mktemp) || { print "Error: failed to create temp file"; return }

  # ensure correct permissions for temp file
  chmod 600 "$tmpfile"

  # write the current command line buffer into the temp file
  print -r -- "$BUFFER" > "$tmpfile"

  # open neovim with F5 mapped to save, close and execute
  nvim +"nnoremap <buffer> <F5> :wq!<CR>" "$tmpfile"

  # load the edited command back into the zsh
  if [[ -r "$tmpfile" ]]; then
    BUFFER=$(<"$tmpfile")
  fi

  # delete temp file
  rm -f "$tmpfile"

  # move cursor to the end of line
  CURSOR=${#BUFFER}

 # execute the command if is not empty
 if [[ -n "$BUFFER" ]]; then
   zle accept-line
 fi
}

zle -N zle-nvim-edit
bindkey '^e' zle-nvim-edit

# up/down keys use smart history search
[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

# CTRL + j/k use smart history search with vim motions 
bindkey '^k' up-line-or-beginning-search
bindkey '^j' down-line-or-beginning-search

# j/k use smart history search with vim motions in normal mode
bindkey -M vicmd 'k' up-line-or-beginning-search
bindkey -M vicmd 'j' down-line-or-beginning-search

# Use vim motins in completion menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# Fix delete key in vim mode
bindkey -v '^?' backward-delete-char

# Exit insert mode
bindkey -M viins 'jk' vi-cmd-mode
