# Aliases
alias vim=nvim
alias k=kubectl
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
export WORKSPACE=$HOME/workspace
export PATH=$HOME/.local/bin:$PATH #for fdfind
export CONFIGS_DIR=$WORKSPACE/configs/
export CONFIGS_PKGS_DIR=$WORKSPACE/configs/packages/
export CONFIGS_DOTFILES_DIR=$WORKSPACE/configs/packages/dotfiles/
export CONFIGS_NVIM_DIR=$WORKSPACE/configs/packages/nvim/
export CONFIGS_ALACRITTY_DIR=$WORKSPACE/configs/packages/alacritty/
export CONFIGS_HYPRLAND_DIR=$WORKSPACE/configs/packages/hypr/
export CONFIGS_WAYBAR_DIR=$WORKSPACE/configs/packages/waybar/


# Work file
if [ -e ~/.zshwork ]; then
  source ~/.zshwork
fi
# Deno
export DENO_INSTALL="/home/$(whoami)/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
# Go
export PATH="$HOME/go/bin:$PATH"
#copy paste
#!/bin/bash

# Function to check if the system is macOS
is_mac_os() {
    if [[ $(uname) == "Darwin" ]]; then
        return 0
    else
        return 1
    fi
}

# Example usage
if ! is_mac_os; then
    alias pbcopy=wl-copy
    alias pbpaste=wl-paste
fi

# Containerized neovim
function nvim-docker() {
    # Docker image name
    local image_name="development-nvim"
    # Default command is nvim, adjusted based on the first parameter
    local command="nvim"
    local target="/bench"

    # If the first argument is 'bash', set the command to /bin/bash
    # and adjust the target accordingly
    if [[ "$1" == "bash" ]]; then
        command="/bin/bash"
        target=""  # No target directory needed for bash
        docker run -it --rm --group-add dialout -v "$image_name:/home" -v "$WORKSPACE:/workspace" --user "$(id -u):$(id -g)" --name "$image_name" "$image_name" $command
      else
        # Extract the absolute path of the file for nvim
        local file_path="$2"
        local file_dir=$(dirname "$file_path")
        echo $file_dir
        local file_name=$(basename "$file_path")
        target="$target/$file_name"  # Adjust target for nvim
        docker run -it --rm --group-add dialout -v "$image_name:/home" -v "$WORKSPACE:/workspace" -v "$file_dir:/bench" --user "$(id -u):$(id -g)" --name "$image_name" "$image_name" $command "$target"
    fi

    # Run the Docker container with the determined command
}

# Export the function if necessary, depending on your shell
alias devvim="nvim-docker nvim"
alias devenv="nvim-docker bash"
