#!/usr/bin/env bash

pushd $(dirname $0) > /dev/null
DOTDIR=$(pwd -P)
popd > /dev/null

OS=$(uname | awk '{print tolower($0)}')

verbose=0
while [[ $# > 0 ]]; do
    key="$1"
    case $key in
        -v|--verbose)
            verbose=1
            ;;
        *)
            ;;
    esac
    shift
done

log() {
    [[ $verbose -eq 1 ]] && echo "$1"
}

has() {
    command -v "$1" >/dev/null 2&>1
}

query() {
    read -r -n1 -p "${1:-Continue?} [y/N] " response
    echo
    response=${response,,}
    [[ "$response" == "y" ]]
}

wrong_os() {
    [[ "$1" =~ (linux|darwin) ]] && ! [[ "$1" =~ "$OS" ]]
}

install() {
    prefix=${2:-""}
    for src in $(find -H "$DOTDIR/$1" -type f); do
        dst=$(echo "$src" | sed 's|'$DOTDIR/$1/'|'$HOME/.$prefix'|')
        dir=$(dirname "$dst")
        name=$(basename "$dst")
        copy=0

        wrong_os "$name" && { log "Ignoring $name."; continue; }

        if [ ! -d "$dir" ]; then
            log "Creating $dir."
            mkdir -p "$dir"
        fi

        # Remove "copy" from filename if present.
        [[ "$name" =~ ".copy" ]] && { copy=1; dst=${dst%.copy}; }

        # Delete symlinks.
        [ -L "$dst" ] && { log "Removing $dst"; rm $dst; }

        # Backup regular files.
        [ -f "$dst" ] && { log "Backing up $dst"; mv $dst $dst.old; }

        if [[ $copy -eq 1 ]]; then
            log "Copying $name to $dst"
            cp $src $dst
        else
            log "Symlinking $name to $dst"
            ln -s $src $dst
        fi
    done
}

setup_vim() {
    vimhome="$HOME/${1:-.vim}"
    pathogen="$vimhome/autoload/pathogen.vim"

    log "Installing pathogin to $pathogen"

    mkdir -p "$vimhome/autoload"
    mkdir -p "$vimhome/bundle"
    if [ -e "$pathogen" ]; then
        query "Pathogen is already installed. Overwrite?" || return
    fi
    curl -LSso "$pathogen" "https://tpo.pe/pathogen.vim"
}

setup_gitconfig() {
    read -r -p "What is your name? " name
    read -r -p "What is your email? " email
    git config --global user.name "$name"
    git config --global user.email "$email"
}

query "Install common config files?" && install "common"
(has xrdb && query "Install x11 related files?") && install "x11"

