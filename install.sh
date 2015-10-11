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
            # mkdir -p "$dir"
        fi

        if [ -e "$dst" ]; then
            if [ $(readlink -f "$dst") == "$src" ]; then
                echo "$name is already installed. Ignoring."
                continue
            fi

            query "File $dst exists. Overwrite?" || { echo "Ignoring $name"; continue; }
        fi

        case $1 in
            "symlink")
                echo "Linking $name"
                # ln -sf "$src" "$dst"
                ;;
            "copy")
                echo "Copying $name"
                # cp -f "$src" "$dst"
                ;;
            *)
                ;;
        esac
    done
}

install_vim_plugins() {
    $(command -v nvim) >/dev/null 2>&1 || { echo >&2 "Neovim is not installed. Aborting."; exit 1; }
}

query "Symlink files in 'symlink'?" && install_files "symlink"
query "Copy files in 'copy'?" && install_files "copy"
# install_symlinks
# install_samples
# install_vim_plugins

