#!/bin/bash

if ! command -v "brew" >/dev/null 2>&1
then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew bundle
