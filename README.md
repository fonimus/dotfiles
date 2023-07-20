# .dotfiles

## Installation

```shell
mkdir -p $HOME/Dev
# clone or download zip from github
git clone https://github.com/fonimus/dotfiles $HOME/Dev/dotfiles
cd $HOME/Dev/dotfiles
./setup.sh
```

### Track macos settings changes

```shell
defaults read > /tmp/before
# change settings in UI
defaults read > /tmp/after && diff /tmp/before /tmp/after
```
