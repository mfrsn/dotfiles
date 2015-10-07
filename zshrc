# zsh setup {{{
source ~/.config/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
autoload -U compinit promptinit colors
compinit
promptinit
colors

bindkey -e

PROMPT="
%{$fg[red]%} » %{$reset_color%}"
RPROMPT="%B%{$fg[cyan]%}%~%{$reset_color%}"

setopt AUTO_CD
setopt CORRECT
setopt COMPLETE_ALIASES
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_VERIFY
setopt HIST_IGNORE_ALL_DUPS
# setopt MENU_COMPLETE
export HISTFILE="${HOME}"/.zsh_history
export HISTSIZE=1000
export SAVEHIST=$HISTSIZE

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors 'reply=( "=(#b)(*$VAR)(?)*=00=$color[green]=$color[bg-green]" )'
zstyle ':completion:*:*:*:*:hosts' list-colors '=*=30;41'
zstyle ':completion:*:*:*:*:users' list-colors '=*=$color[green]=$color[red]'
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# }}}

# Base16 Shell
if [ -n "$PS1" ]; then
    eval "$(~/Scripts/base16-shell/profile_helper.sh)"
fi

# Functions {{{
conf() {
  case $1 in
    zsh)    $EDITOR ~/.zshrc && source ~/.zshrc ;;
    vim)    $EDITOR ~/.vimrc ;;
    nvim)   $EDITOR ~/.nvimrc ;;
    tmux)   $EDITOR ~/.tmux.conf ;;
    *)      echo "Unknown application" ;;
  esac
}

course() {
  cd ~/Documents/School/$1
}

# Colored man pages
man() {
  env LESS_TERMCAP_mb=$'\E[01;31m' \
  LESS_TERMCAP_md=$'\E[01;38;5;74m' \
  LESS_TERMCAP_me=$'\E[0m' \
  LESS_TERMCAP_se=$'\E[0m' \
  LESS_TERMCAP_so=$'\E[38;5;246m' \
  LESS_TERMCAP_ue=$'\E[0m' \
  LESS_TERMCAP_us=$'\E[04;38;5;146m' \
  man "$@"
}
# }}}

# Aliases {{{
# ls
alias ls='ls -hFG'
alias ll='ls -l'
alias lr='ls -R'
alias la='ll -A'
alias lx='ll -BX'               # Sort by extension
alias lz='ll -rS'               # Sort by size
alias lt='ll -rT'               # Sort by time
alias lm='la | less'

# Modified commands
alias cp='cp -i'
alias mv='mv -i'
alias grep='grep -i'
#alias diff='colordiff'
alias mkdir='mkdir -p -v'
alias ping='ping -c 5'
alias df='df -h'
alias du='du -c -h'
#alias nasm='/usr/local/bin/nasm'
#alias qemu='qemu-system-x86_64 '
alias tmux="tmux -2"
alias vim="nvim"
alias cal="gcal --iso-week-number=yes --starting-day=1"

# New commands
alias ..='cd ..'
alias ....='cd ../..'
alias ......='cd ../../..'
#alias gpg='gpg2'

# Git
# alias gs='git status'
# alias gf='git fetch'
# alias gc='git commit'
# alias gm='git merge'
# alias gmo='git merge origin/master'
# alias gp='git push'
# alias gb='git branch'
# alias gl='git log --oneline'
# alias gll='git log'
# alias ga='git add'
# alias gch='git checkout'
# alias gcb='git checkout -b'
# }}}

# Path
#path[1,0]=/usr/local/bin
path+=~/bin
path+=~/Scripts
path+=~/Tools/i686-elf/bin
path+=~/Tools/MinGW64/bin
#path+=~/Tools/OSDev/bin
path+=/usr/local/sbin

export EDITOR="nvim"
export SUDO_EDITOR="nvim"

# FZF {{{
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

fe() {
  local file
  file=$(fzf --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && $EDITOR "$file"
}

# }}}
