eval "$(/opt/homebrew/bin/brew shellenv)"
source /opt/homebrew/share/antigen/antigen.zsh

antigen use oh-my-zsh

for file in $HOME/.{aliases,exports,functions}; do
    [ -r "$file" ] && source "$file"
done
unset file

antigen bundle git
antigen bundle sudo
antigen bundle z
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions

antigen bundle history-substring-search

antigen bundle lukechilds/zsh-better-npm-completion
antigen bundle chrissicool/zsh-256color
antigen bundle tomsquest/nvm-auto-use.zsh

antigen bundle macos
antigen bundle yarn

antigen apply

[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

[ -f "$GCLOUD_DIR/path.zsh.inc" ] && source "$GCLOUD_DIR/path.zsh.inc"
[ -f "$GCLOUD_DIR/completion.zsh.inc" ] && source "$GCLOUD_DIR/completion.zsh.inc"

source "$HOME/.antigen/bundles/lukechilds/zsh-better-npm-completion/zsh-better-npm-completion.plugin.zsh"
