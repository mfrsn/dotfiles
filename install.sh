#!/usr/bin/env bash

pushd $(dirname $0) > /dev/null
DOTDIR=$(pwd -P)
popd > /dev/null

OS=$(uname | awk '{print tolower($0)}')

query() {
    read -r -p "${1:-Continue?} [y/N] " response
    response=${response,,}
    [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
}

is_os_specific() {
    [[ "$1" =~ (linux|darwin) ]]
}

matches_os() {
    [[ "$1" =~ "$OS" ]]
}

install_files() {
    for src in $(find -H "$DOTDIR/$1" -type f); do
        dst=$(echo "$src" | sed 's|'$DOTDIR/$1/'|'$HOME/.'|')
        dir=$(dirname "$dst")
        name=$(basename "$dst")

        (is_os_specific "$name" && ! matches_os "$name") && { echo "Ignoring $name"; continue; }

        if [ ! -d "$dir" ]; then
            echo "Directory $dir doesn't exist. Creating."
            mkdir -p "$dir"
        fi

        if [ -e "$dst" ]; then
            if [ $(readlink -f "$dst") == "$src" ]; then
                echo "$name is already installed. Ignoring."
                continue
            fi

            query "File $dst exists. Overwrite?" || { echo "Ignoring $name"; continue; }
        fi

        case $2 in
            "symlink")
                echo "Linking $name"
                ln -sf "$src" "$dst"
                ;;
            "copy")
                echo "Copying $name"
                cp -f "$src" "$dst"
                ;;
            *)
                ;;
        esac
    done
}

symlink_files() {
    install_files "$1" "symlink"
}

copy_files() {
    install_files "$1" "copy"
}

setup_vim() {
    vimhome="$HOME/${1:-.vim}"
    pathogen="$vimhome/autoload/pathogen.vim"

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

symlink=false
copy=false
git=false
vim=false
plugins=false
x11=false

while [[ $# > 0 ]]; do
    key="$1"
    case $key in
        -s|--symlink)
            symlink=true
            ;;
        -c|--copy)
            copy=true
            ;;
        -g|--git)
            git=true
            ;;
        -v|--vim)
            vim=true
            ;;
        --plugins)
            vim=true
            plugins=true
            ;;
        -x|--x11)
            x11=true
            ;;
        *)
            ;;
    esac
    shift
done

[ "$symlink" = true ] && symlink_files "symlink"
[ "$x11" = true ] && symlink_files "x11"
[ "$copy" = true ] && copy_files "copy"
[ "$git" = true ] && setup_gitconfig
[ "$vim" = true ] && setup_vim
[ "$plugins" = true ] && install_plugins

