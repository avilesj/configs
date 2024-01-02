# Aliases
alias k=kubectl
alias vim=nvim
alias exitt="tmux kill-server"
# ZSH
ZSH_THEME="powerlevel10k/powerlevel10k"
## Vim mode
bindkey -v
## Keybinds
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward
## Make cursor thin in insert mode
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

#Vars
export PATH=$HOME/.local/bin:$PATH #for fdfind
export CONFIGS_DIR=$HOME/Dev/configs/
export CONFIGS_PKGS_DIR=$HOME/Dev/configs/packages/
export CONFIGS_DOTFILES_DIR=$HOME/Dev/configs/packages/dotfiles/
export CONFIGS_NVIM_DIR=$HOME/Dev/configs/packages/nvim/
export CONFIGS_ALACRITTY_DIR=$HOME/Dev/configs/packages/alacritty/


# Work file
if [ -e ~/.zshwork ]; then
  source ~/.zshwork
fi
export DENO_INSTALL="/home/$(whoami)/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
