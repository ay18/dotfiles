# .bashrc for OS X and Linux
# ====================================================================
# - https://github.com/ay18/dotfiles
# - andyyee.dev@gmail.com

export EMAIL="andyyee.dev@gmail.com"
export DEV="$HOME/dev"
export DOTFILES="$DEV/dotfiles"
export PLATFORM=$(uname -s)

if [[ $(uname -p) == 'arm' ]]; then
  export M1=true
fi

if [ "$M1" == true ]; then
  export EDITOR=vim
elif [ "$PLATFORM" = 'Darwin' ]; then
  export EDITOR=code
else
  export EDITOR=vim
fi

# brew Apple silicon
if [ "$M1" == true ]; then
  export PATH=/opt/homebrew/bin:$PATH
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Prompt
# --------------------------------------------------------------------

PS1="△ ($PLATFORM) \w $ "

# brew Apple silicon
export PATH=/opt/homebrew/bin:$PATH
eval "$(/opt/homebrew/bin/brew shellenv)"

# brew install bash-git-prompt
if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  __GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
  GIT_PROMPT_ONLY_IN_REPO=1
  source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi

# brew install bash-completion
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# pip install powerline-shell
function _update_ps1() {
    PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

# Environment
# --------------------------------------------------------------------

# pyenv
if command -v pyenv > /dev/null; then
  eval "$(pyenv init -)"
fi

if [ "$M1" == true ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
fi

# nvm
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPTS='--no-height --no-reverse'

# openssl needed for compilers
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"


# Functions
# --------------------------------------------------------------------
get_current_branch () {
  current_branch="$(git rev-parse --abbrev-ref HEAD)"
}

grbm () {
  get_current_branch
  git checkout master
  git fetch upstream
  git rebase upstream/master
  git push
  git checkout ${current_branch}
  git rebase master
}

gco () {
  if [ $# -eq 0 ]; then
    git branch | fzf | xargs -I {} git checkout {}
  else
    git checkout $@
  fi
}

gpu! () {
  git push -uf origin $(get_current_branch)
}

# copy a filename in dir to clipboard (defaults to current dir)
scl () {
  if [ $# -eq 0 ]; then
    path=.
  else
    path=$1
  fi
  (cd $path && du -a . | awk '{print $2}' | grep -v .git) | fzf | xargs -I "file={}; echo $file" | tr -d '\n' | pbcopy
}

# find and open file in editor
ff () {
  scl $1 && pbpaste | xargs $EDITOR
}


# Keybinds
# --------------------------------------------------------------------

bind -x '"\C-f": ff'


# Aliases
# --------------------------------------------------------------------

# files
alias hosts="sudo $EDITOR /etc/hosts"
alias vimrc="$EDITOR $HOME/.vimrc"
alias bashrc="$EDITOR $HOME/.bashrc"
alias reload=". $HOME/.bashrc"

# directories
alias dev="cd $DEV"
alias dot="cd $DOTFILES"
alias pdot="cd $DEV/private_dotfiles"
alias proj="cd $DEV/projects"
alias lab="cd $DEV/lab"
alias sbox="cd $DEV/sandbox"

alias ...="cd ../.."
alias ....="cd ../../.."

if [ "$PLATFORM" = 'Darwin' ]; then
  alias l.='ls -dG .*'
  alias ll='ls -lG'
  alias ls='ls -G'
else
  alias l.='ls -d .* --color=auto'
  alias ll='ls -l --color=auto'
  alias ls='ls --color=auto'
fi

# dev
alias grh="git reset --hard"
alias gc="git commit"
alias gs="git status"
alias gcl!='git checkout . && git clean -f'

if [ -f "$DEV/private_dotfiles/aws.sh" ]; then
  source "$DEV/private_dotfiles/aws.sh"
fi

export BASH_SILENCE_DEPRECATION_WARNING=1

# Added by serverless binary installer
export PATH="$HOME/.serverless/bin:$PATH"

