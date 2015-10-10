if [ -d ~/.zshrc.d ]; then
  for f in ~/.zshrc.d/*; do
    source "$f"
  done
  unset f
fi

bindkey -e

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
