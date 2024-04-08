# # Source manjaro-zsh-configuration
# if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
#   source /usr/share/zsh/manjaro-zsh-config
# fi
# cat .local/share/cat

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source "/usr/share/fzf/key-bindings.zsh"

# Enable colors and change prompt:
autoload -U colors && colors	# Load colors

# PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[red]%}@%{$fg[magenta]%}%M %{$fg[magenta]%}%~%{$fg[red]%}  ]%{$reset_color%}$%b  "
# PS1="%B%{$fg[red]%}[%{$fg[cyan]%}%n%{$fg[red]%}@%{$fg[magenta]%}%~%{$fg[red]%}]  %{$reset_color%}$%b "
# Prompt
PROMPT="%B%F{red}╭─<%f%F{yellow}%~%f%F{red}>%f"$'\n'"%F{red}╰─λ%f%F{magenta}  "



#{{{ ALIASES
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -vi"
alias gt="gotop"
alias ka="killall"
# use eza instead of ls
alias ls="eza --icons --group-directories-first"
alias lsa="eza -a --icons --group-directories-first"
alias la="eza -lGa "
alias ll="eza -l "
alias la="eza -la --git --group-directories-first "
alias v="nvim"
alias vim="nvim"
alias lb="cd ~/.local/bin/"
alias cfn="cd $HOME/.config/nvim && v ./init.lua"
alias cfd="cd $HOME/.doom.d && v ./config.el"
alias cfa="v ~/.config/alacritty/alacritty.toml"
alias cfi="v ~/.config/i3/config"
alias cfp="v ~/.config/polybar/config.ini"
alias cfb="v ~/.config/bspwm/bspwmrc"
alias cfs="v ~/.config/sxhkd/sxhkdrc"
alias cfk="v ~/.config/kitty/kitty.conf"
alias cfw="cd $HOME/.config/awesome &&  v ./rc.lua"
alias ytd="youtube-dl -x --audio-format mp3 --embed-thumbnail"
alias r="ranger"
alias vw="cd ~/Documents/vimwiki && v -c VimwikiIndex"
alias config="/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME"
# alias ls='ls --color=auto'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'
alias ncdu="ncdu --color dark"
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less
alias p='sudo pacman'
alias keyb='setxkbmap us,gr -option 'grp:alt_shift_toggle' &'
alias dg='dict -d fd-eng-ell'
alias mapweather=' curl -s v3.wttr.in/Athens.png | kitty icat --align=left  '
alias map='telnet mapscii.me'
#}}}

function tdoc(){
    xdg-open http://texdoc.net/pkg/$1
}

setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments
setopt histignorealldups   # If a new command is a duplicate, remove the older one
setopt inc_append_history # save commands are added to the history immediately, otherwise only when shell exits

# History in cache directory:
HISTSIZE=100000
SAVEHIST=100000
# HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

#------------------------------
# Keybindings
#------------------------------
bindkey -v
typeset -g -A key
# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey '^?' backward-delete-char

bindkey '^[[5~' up-line-or-history      # Page up key
bindkey '^[[3~' delete-char             # Delete key
bindkey '^[[6~' down-line-or-history    # Page down key
bindkey '^[[A' up-line-or-search
bindkey '^[[D' backward-char            # Left key
bindkey '^[[B' down-line-or-search
bindkey '^[[C' forward-char             # Right key
bindkey "^[[H" beginning-of-line        # Home key
bindkey "^[[F" end-of-line              # End key
# bindkey -s '^o' 'nvim $(fzf)^M' # -s option is used to translate the input string to output string so that when you press the shortcut, it is replaced with the command you want to run. ^M or \n is used to represent the Enter key so that the command is run automatically.

bindkey -s '^o' "cd_with_fzf\n"

cd_with_fzf() {
cd "$(find -type d | fzf --preview="eza -T 1 {}" --bind="space:toggle-preview" --preview-window=:hidden)" && clear
}

open(){
    xdg-open "$(find -type f | fzf)"
}

pacs() {
sudo pacman -Syy $(pacman -Ssq | fzf -m --preview="pacman -Si {}" --preview-window=:hidden --bind=space:toggle-preview)
}

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

#{{{ Change cursor shape for different vi modes.
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
#}}}


#{{{ Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-R
#}}}

zle -N zle-keymap-select

#{{{---------------- Set window/tab title-----------------------------
function title {
  emulate -L zsh
  setopt prompt_subst

  [[ "$EMACS" == *term* ]] && return

  # if $2 is unset use $1 as default
  # if it is set and empty, leave it as is
  : ${2=$1}

  case "$TERM" in
    xterm*|putty*|rxvt*|konsole*|ansi|mlterm*|alacritty|st*)
      print -Pn "\e]2;${2:q}\a" # set window name
      print -Pn "\e]1;${1:q}\a" # set tab name
      ;;
    screen*|tmux*)
      print -Pn "\ek${1:q}\e\\" # set screen hardstatus
      ;;
    *)
    # Try to use terminfo to set the title
    # If the feature is available set title
    if [[ -n "$terminfo[fsl]" ]] && [[ -n "$terminfo[tsl]" ]]; then
      echoti tsl
      print -Pn "$1"
      echoti fsl
    fi
      ;;
  esac
}
ZSH_THEME_TERM_TAB_TITLE_IDLE="%15<..<%~%<<" #15 char left truncated PWD
ZSH_THEME_TERM_TITLE_IDLE="%~"
#{{{ func Runs before showing the prompt
function mzc_termsupport_precmd {
  [[ "${DISABLE_AUTO_TITLE:-}" == true ]] && return
  title $ZSH_THEME_TERM_TAB_TITLE_IDLE $ZSH_THEME_TERM_TITLE_IDLE
}

# Runs before executing the command
function mzc_termsupport_preexec {
  [[ "${DISABLE_AUTO_TITLE:-}" == true ]] && return

  emulate -L zsh

  # split command into array of arguments
  local -a cmdargs
  cmdargs=("${(z)2}")
  # if running fg, extract the command from the job description
  if [[ "${cmdargs[1]}" = fg ]]; then
    # get the job id from the first argument passed to the fg command
    local job_id jobspec="${cmdargs[2]#%}"
    # http://zsh.sourceforge.net/Doc/Release/Jobs-_0026-Signals.html#Jobs
    # https://www.zsh.org/mla/users/2007/msg00704.html
    case "$jobspec" in
      <->) # %number argument:
        # use the same <number> passed as an argument
        job_id=${jobspec} ;;
      ""|%|+) # empty, %% or %+ argument:
        # use the current job, which appears with a + in $jobstates:
        # suspended:+:5071=suspended (tty output)
        job_id=${(k)jobstates[(r)*:+:*]} ;;
      -) # %- argument:
        # use the previous job, which appears with a - in $jobstates:
        # suspended:-:6493=suspended (signal)
        job_id=${(k)jobstates[(r)*:-:*]} ;;
      [?]*) # %?string argument:
        # use $jobtexts to match for a job whose command *contains* <string>
        job_id=${(k)jobtexts[(r)*${(Q)jobspec}*]} ;;
      *) # %string argument:
        # use $jobtexts to match for a job whose command *starts with* <string>
        job_id=${(k)jobtexts[(r)${(Q)jobspec}*]} ;;
    esac

    # override preexec function arguments with job command
    if [[ -n "${jobtexts[$job_id]}" ]]; then
      1="${jobtexts[$job_id]}"
      2="${jobtexts[$job_id]}"
    fi
  fi

  # cmd name only, or if this is sudo or ssh, the next cmd
  local CMD=${1[(wr)^(*=*|sudo|ssh|mosh|rake|-*)]:gs/%/%%}
  local LINE="${2:gs/%/%%}"

  title '$CMD' '%100>...>$LINE%<<'
}
#}}}
autoload -U add-zsh-hook
add-zsh-hook precmd mzc_termsupport_precmd
add-zsh-hook preexec mzc_termsupport_preexec
#}}}

# ----------Use history substring search----------------------------------
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
# bind UP and DOWN arrow keys to history substring search
zmodload zsh/terminfo
# bindkey "$terminfo[kcuu1]" history-substring-search-up
# bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up			
bindkey '^[[B' history-substring-search-down
# Load syntax highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
