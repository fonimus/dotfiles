#!/bin/bash

set -euo pipefail

print_success() {
    # Print output in green
    printf "\e[0;32m  [✔] %s\e[0m\n" "$1"
}

print_info() {
    # Print output in purple
    printf "\e[0;35m %s\e[0m\n" "$1"
}

create_link() {
    local -r SRC=$1
    local -r DEST=$2

    mkdir -p "$(dirname "$DEST")"
    if ! [ -L "$DEST" ] || [ "$FORCE" = true ]; then
        ln -isv "$SRC" "$DEST"
    else
        print_info "Skipping, symlink already exists: $DEST"
    fi
}

FORCE=false
if [ "$#" -gt 0 ] && { [ "$1" == "--force" ] || [ "$1" == "-f" ]; }; then
    FORCE=true
fi

declare -a FILES_TO_SYMLINK
FILES_TO_SYMLINK=($(find . -type f -maxdepth 1 -not -name .DS_Store -not -name .gitignore -not -name README.md -not -name Brewfile -not -name "*.sh" | sed -e "s|./||"))

for file in "${FILES_TO_SYMLINK[@]}"; do
    create_link "$PWD/$file" "$HOME/.$file"
done

mkdir -p $HOME/Dev

create_link "$PWD/prefs/sublime-text.json" "$HOME/Library/Application Support/Sublime Text/Packages/User/Preferences.sublime-settings"
create_link "$PWD/k9s/views.yml" "$HOME/k9s/views.yml"
create_link "$PWD/k9s/plugin.yml" "$HOME/k9s/plugin.yml"
create_link "$PWD/Brewfile" "$HOME/Brewfile"

echo ""
read -rp "Update OSX defaults? (y/n) " -n 1
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    ./macos.sh
fi

echo ""
read -rp "Install homebrew? (y/n) " -n 1
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo ""
read -rp "Launch brew bundle? (y/n) " -n 1
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    brew bundle
fi

