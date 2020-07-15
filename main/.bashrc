# .bashrc for OS X and Ubuntu
# ====================================================================
# - https://github.com/ay18/dotfiles
# - andyych88@gmail.com

export EMAIL="andyych88@gmail.com"
export DEV="$HOME/dev"
export DOTFILES="$DEV/dotfiles"
export EDITOR=code
export PLATFORM=$(uname -s)


# Prompt
# --------------------------------------------------------------------

PS1="△  \w $ "
# brew install bash-git-prompt
if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  __GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
  GIT_PROMPT_ONLY_IN_REPO=1
  source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi

# brew install bash-completion
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"


# Environment
# --------------------------------------------------------------------

# direnv
eval "$(direnv hook bash)"

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# nvm
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPTS='--no-height --no-reverse'


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

# dev
alias grh="git reset --hard"
alias gc="git commit"
alias gs="git status"
alias gcl!='git checkout . && git clean -f'

if [ -f "$DEV/private_dotfiles/venmo.sh" ]; then
  source "$DEV/private_dotfiles/venmo.sh"
fi