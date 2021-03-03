
# profile file runs on login. Environmental variables
# [[ -f ~/.bashrc ]] && . ~/.bashrc

# Adds `~/.local/bin` to $PATH
export PATH=$PATH":$HOME/.local/bin" 
export VISUAL="nvim"
export EDITOR="nvim"
export SHELL=/bin/zsh
export QT_QPA_PLATFORMTHEME="qt5ct"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
# fix "xdg-open fork-bomb" export your preferred browser from here
export BROWSER=firefox
export TERMINAL=kitty
export BIB="$HOME/Documents/LaTeX/Library/lib.bib"
export FZF_DEFAULT_COMMAND='find .'
# ~/ Clean-up:
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
# stop creating .lesshst file
export LESSHISTFILE=-
export PYLINTHOME="$XDG_CACHE_HOME"/pylint
export PYLINTRC="$XDG_CONFIG_HOME"/pylintrc
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export GOPATH="$XDG_DATA_HOME"/go
