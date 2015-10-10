conf() {
  case $1 in
    zsh)    $EDITOR ~/.zshrc && source ~/.zshrc ;;
    vim)    $EDITOR ~/.vimrc ;;
    nvim)   $EDITOR ~/.nvimrc ;;
    tmux)   $EDITOR ~/.tmux.conf ;;
    *)      echo "Unknown application" ;;
  esac
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

# Edit file using fzf
fe() {
  local file
  file=$(fzf --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && $EDITOR "$file"
}

fo() {
  local file
  file=$(fzf --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && open "$file"
}
