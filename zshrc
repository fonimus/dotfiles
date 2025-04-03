eval "$(/opt/homebrew/bin/brew shellenv)"
source /opt/homebrew/share/antigen/antigen.zsh

antigen use oh-my-zsh

for file in $HOME/.{aliases,exports,functions}; do
    [ -r "$file" ] && source "$file"
done
unset file

[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

[ -f "$GCLOUD_DIR/path.zsh.inc" ] && source "$GCLOUD_DIR/path.zsh.inc"
[ -f "$GCLOUD_DIR/completion.zsh.inc" ] && source "$GCLOUD_DIR/completion.zsh.inc"


antigen bundle git
antigen bundle sudo
antigen bundle z
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions

antigen bundle history-substring-search

antigen bundle lukechilds/zsh-better-npm-completion
antigen bundle chrissicool/zsh-256color

antigen bundle macos
antigen bundle yarn

antigen apply

source "$HOME/.antigen/bundles/lukechilds/zsh-better-npm-completion/zsh-better-npm-completion.plugin.zsh"

# pure configuration -- start

fpath+=("$(brew --prefix)/share/zsh/site-functions")
autoload -U promptinit; promptinit

PURE_CMD_MAX_EXEC_TIME=1

zstyle :prompt:pure:path color cyan
zstyle :prompt:pure:prompt:success color green
zstyle :prompt:pure:git:stash show yes

prompt pure

# pure configuration -- end

autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/fonimus/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

eval "$(direnv hook zsh)"
