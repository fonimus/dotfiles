#!/bin/bash

set -euo pipefail

print_color() {
    printf "\e[0;$1m [$2] %s\e[0m\n" "$3"
}

print_info() {
    print_color "34" "." "$1"
}

print_success() {
    print_color "32" "✔" "$1"
}

print_ignored() {
    print_color "33" "✗" "$1"
}

ask() {
    printf "\e[0;31m [?] %s\e[0m " "$1 (y/n)"
    read -rp "" -n 1
    printf "\n"
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_info "Launching $2"
        eval $2
    else
      print_ignored "Skipping $2"
    fi
}

create_link() {
    local -r SRC=$1
    local -r DEST=$2

    mkdir -p "$(dirname "$DEST")"
    if ! [ -L "$DEST" ] || [ "$FORCE" = true ]; then
        ln -isv "$SRC" "$DEST"
    fi
}

FORCE=false
if [ "$#" -gt 0 ] && { [ "$1" == "--force" ] || [ "$1" == "-f" ]; }; then
    FORCE=true
fi

declare -a FILES_TO_SYMLINK
FILES_TO_SYMLINK=($(find . -type f -maxdepth 1 -not -name .DS_Store -not -name .gitignore -not -name README.md -not -name Brewfile -not -name "*.sh" | sed -e "s|./||"))

print_info "Starting to initialize mac"

print_info "Creating links..."

for file in "${FILES_TO_SYMLINK[@]}"; do
    create_link "$PWD/$file" "$HOME/.$file"
done

create_link "$PWD/prefs/sublime-text.json" "$HOME/Library/Application Support/Sublime Text/Packages/User/Preferences.sublime-settings"
create_link "$PWD/k9s/views.yml" "$HOME/k9s/views.yml"
create_link "$PWD/k9s/plugin.yml" "$HOME/k9s/plugin.yml"
create_link "$PWD/Brewfile" "$HOME/Brewfile"
create_link "$PWD/ssh/config" "$HOME/.ssh/config"

print_info "Links created"

ask "Launch brew bundle ?" ./brew.sh
ask "Update OSX settings ?" ./macos.sh

print_success "Mac initialized !"
