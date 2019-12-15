#!/usr/bin/env bash
# .bashrc for OS X and Ubuntu
# ====================================================================
# - https://github.com/junegunn/dotfiles
# - junegunn.c@gmail.com

export EMAIL="andyych88@gmail.com"
export DOTFILES=~"/dev/dotfiles"

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

#  brew install bash-git-prompt
if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  __GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
  GIT_PROMPT_ONLY_IN_REPO=1
  source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi

miniprompt() {
  unset PROMPT_COMMAND
  PS1="\[\e[38;5;168m\]> \[\e[0m\]"
}

# Aliases
# --------------------------------------------------------------------

# files
alias hosts="sudo $EDITOR /etc/hosts"
alias vimrc="$EDITOR ~/.vimrc"
alias bashrc="$EDITOR ~/.bashrc"
alias reload=". $DOTFILES/.bashrc"

# directories
alias dev="cd ~/dev"
alias dotfiles="cd $DOTFILES"
alias proj="cd ~/dev/projects"
alias lab="cd ~/dev/lab"

# dev
alias grh="git reset --hard"

. ./work_dotfiles/venmo.sh