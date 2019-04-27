# Dev environment
# Andy Yee [anyych88@gmail.com] 2018

# Export PATH for homebrew.
export PATH="/usr/local/sbin:$PATH"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--no-height --no-reverse'

# direnv
eval "$(direnv hook bash)"

# jenv
eval "$(jenv init -)"

# python through homebrew, prefer pyenv
# export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# pyenv
eval "$(pyenv init -)"

# nvm
export NVM_DIR="$HOME/.nvm"
if [[ -z "${NVM_BIN}" ]]; then
  . "/usr/local/opt/nvm/nvm.sh"
fi

# php
export PATH="/usr/local/opt/php@7.2/bin:$PATH"
export PATH="/usr/local/opt/php@7.2/sbin:$PATH"
export LDFLAGS="-L/usr/local/opt/php@7.2/lib"
export CPPFLAGS="-I/usr/local/opt/php@7.2/include"

# composer
export PATH="$PATH:$HOME/.composer/vendor/bin"
