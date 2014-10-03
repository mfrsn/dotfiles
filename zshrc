source ~/.config/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
autoload -U compinit promptinit colors
compinit
promptinit
colors

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
export HISTFILE="${HOME}"/.zsh_history
export HISTSIZE=1000
export SAVEHIST=$HISTSIZE

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors 'reply=( "=(#b)(*$VAR)(?)*=00=$color[green]=$color[bg-green]" )'
zstyle ':completion:*:*:*:*:hosts' list-colors '=*=30;41'
zstyle ':completion:*:*:*:*:users' list-colors '=*=$color[green]=$color[red]'
zstyle ':completion:*' menu select

# Base16 Shell
BASE16_SCHEME="ocean"
BASE16_SHELL="$HOME/.config/base16-shell/base16-$BASE16_SCHEME.dark.sh"
[[ -s $BASE16_SHELL ]] && . $BASE16_SHELL

# Shortcut functions
conf() {
    case $1 in
        zsh)    vim ~/.zshrc && source ~/.zshrc ;;
        vim)    vim ~/.vimrc ;;
        tmux)   vim ~/.tmux.conf ;;
        *)      echo "Unknown application" ;;
    esac
}

#
#Aliases
#

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

# New commands
alias ..='cd ..'
alias ....='cd ../..'
alias ......='cd ../../..'
#alias gpg='gpg2'

# Git
alias gs='git status'
alias gf='git fetch'
alias gc='git commit'
alias gm='git merge'
alias gmo='git merge origin/master'
alias gp='git push'
alias gb='git branch'
alias gl='git log --oneline'
alias gll='git log'
alias ga='git add'
alias gch='git checkout'
alias gcb='git checkout -b'

# Path
path+=~/bin
path+=~/Scripts
#path+=~/Tools/llvm/bin
path+=~/Tools/MinGW64/bin
path+=~/Tools/OSDev/bin
#path+=~/.usr/local/bin
path+=/usr/local/sbin

export PATH="/usr/local/bin:$PATH"
export EDITOR="vim"
export SUDO_EDITOR="vim"
