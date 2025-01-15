# profile file runs on login. Environmental variables
# [[ -f ~/.bashrc ]] && . ~/.bashrc

# Adds `~/.local/bin` to $PATH
# export PATH=$PATH":$HOME/.local/bin" 
export PATH="$HOME/.local/bin:$PATH:${$(find ~/.local/bin -type d -printf %p:)%%:}"

export VISUAL="nvim"
export EDITOR="nvim"
export SHELL=/bin/zsh
export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_STYLE_OVERRIDE="kvantum"
# export BROWSER="/usr/bin/firefox"
# export BROWSER="librewolf"
export BROWSER="zen-browser"
export TERMINAL="alacritty"
export BIB="$HOME/Documents/LaTeX/CitationLib/lib.bib"
export NOTES_DIR="$HOME/Documents/Notes"
# export FZF_DEFAULT_COMMAND='find .'

# ~/ Clean-up:
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export HISTFILE="$XDG_DATA_HOME"/zsh/history

export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export IPYTHONDIR="$XDG_CONFIG_HOME"/jupyter
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
# stop creating .lesshst file
export LESSHISTFILE="-"
export PYLINTHOME="$XDG_CACHE_HOME"/pylint
export PYLINTRC="$XDG_CONFIG_HOME"/pylintrc
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export GOPATH="$XDG_DATA_HOME"/go
export TEXMFHOME=$XDG_DATA_HOME/texmf
export TEXMFVAR=$XDG_CACHE_HOME/texlive/texmf-var
export TEXMFCONFIG=$XDG_CONFIG_HOME/texlive/texmf-config
# export ZDOTDIR=$HOME/.config/zsh

# Man Pages Color:
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

if [[ "$(tty)" = "/dev/tty1" ]]; then
	pgrep bspwm || startx 
fi

# eval "$(gh completion -s zsh)"

export HISTTIMEFORMAT="%d/%m/%y %T "
