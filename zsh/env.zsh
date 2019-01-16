# Dev environment
# Andy Yee [cyee@wayfair.com] 2018

# Export PATH for homebrew.
export PATH="/usr/local/sbin:$PATH"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--no-height --no-reverse'

# direnv
eval "$(direnv hook bash)"

# jenv
eval "$(jenv init -)"

# python
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# nvm
export NVM_DIR="$HOME/.nvm"
if [[ -z "${NVM_BIN}" ]]; then
  . "/usr/local/opt/nvm/nvm.sh"
fi

# composer
export PATH="$PATH:$HOME/.composer/vendor/bin"
