# .dotfiles

## Installation

```shell
mkdir -p $HOME/Dev
# download zip from github
cd $HOME/Dev/dotfiles
./setup.sh
```

### Track macos settings changes

```shell
defaults read > /tmp/before
# change settings in UI
defaults read > /tmp/after && diff /tmp/before /tmp/after
```
