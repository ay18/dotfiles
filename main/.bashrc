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

if [ "$PLATFORM" = Linux ]; then
  PS1="\[\e[1;38m\]\u\[\e[1;34m\]@\[\e[1;31m\]\h\[\e[1;30m\]:"
  PS1="$PS1\[\e[0;38m\]\w\[\e[1;35m\]> \[\e[0m\]"
else
  ### git-prompt
  __git_ps1() { :;}
  if [ -e ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
  fi
  PS1="\[\e[34m\]\u\[\e[1;32m\]@\[\e[0;33m\]\h\[\e[35m\]:\[\e[m\]\w\[\e[1;30m\]$(__git_ps1)\[\e[1;31m\]> \[\e[0m\]"
fi

# brew install bash-git-prompt
if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  __GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
  GIT_PROMPT_ONLY_IN_REPO=1
  source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi

# brew install bash-completion
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

miniprompt() {
  unset PROMPT_COMMAND
  PS1="\[\e[38;5;168m\]> \[\e[0m\]"
}

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

function grbm () {
  get_current_branch
  git checkout master
  git fetch upstream
  git rebase upstream/master
  git push
  git checkout ${current_branch}
  git rebase master
}

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
alias gco="git checkout"
alias gs="git status"
alias gcl!='git checkout . && git clean -f'
alias gpu!="git push -uf origin $(get_current_branch)"

if [ -f "$DEV/private_dotfiles/venmo.sh" ]; then
  source "$DEV/private_dotfiles/venmo.sh"
fi