# .bashrc
# ==============================================================
# * https://github.com/sksea/dotfiles
# * andy.sksea@gmail.com

# CONFIG
# ---------------------------------------------------------------
EDITOR="vim"

# Bash prompt PS1
# colors
CLR="\[$(tput sgr0)\]"
C_BLUE="$CLR\[\033[38;5;39m\]"
C_YELLOW="$CLR\[\033[38;5;228m\]"
C_RED="$CLR\[\033[38;5;203m\]"
TRI="$(echo -e '\xe2\x96\xb2')"

# prompt
export PS1="\n$C_BLUE\W $C_YELLOW$TRI$C_RED\$(parse_git_branch)\n> $CLR"

# Set terminal tab name to current directory.
export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'


# PLUGINS
# ---------------------------------------------------------------

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Update PATH for homebrew.
export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"

# golang
export GOPATH=$HOME/dev-local/golang
export PATH=$PATH:$GOPATH/bin

# nvm
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

# fzf
[ -f ~/.fzf.bash  ] && source ~/.fzf.bash
# remap fzf in bash.
if [ $BASH_VERSINFO -gt 3  ]; then
  bind -r "\C-t"
  bind -x '"\C-f": "fzf-file-widget"'
fi

# direnv
eval "$(direnv hook bash)"

# brew-bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then # brew dep
	. $(brew --prefix)/etc/bash_completion
fi

# Git-bash completion
#source ~/.git-completion.bash

# Git branch in prompt.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}


# ALIASES
# ---------------------------------------------------------------

# system
alias rm='rmtrash'
alias ls='ls -aFG'
alias mkdir='mkdir -p'

# dev
alias pip='pip3'
alias pipls='pip list --format=columns'
alias npmls='npm -g ls --depth=0'
alias npmu='npm-check-updates'
alias g++='g++ -Wall -Wconversion -pedantic -std=c++11'
alias webpack='webpack --config webpack.config.prod.js --watch'
alias webpackdev='webpack-dev-server --config webpack.config.dev.js --watch'
#alias python='python3'

# files
alias hosts='sudo $EDITOR /etc/hosts'
alias vimrc='$EDITOR ~/.vimrc'
alias bashrc='$EDITOR ~/.bashrc'
alias reload='. ~/.bashrc'
alias irbrc='$EDITOR ~/.irbrc'
# alias envvars='$EDITOR ~/.global_env_vars.sh'

# directories
alias drive='cd ~/Google\ Drive'
alias cellar='cd /usr/local/Cellar'
alias devgd='cd ~/Google\ Drive/dev'
# dotfiles is a symlinked directory, many symlinked files depend on it.
alias dotfiles='cd ~/Google\ Drive/dev/dotfiles'

# personal project directories
alias dev='cd ~/dev-local/main'
alias sb='cd ~/dev-local/sandbox'
alias notes='cd ~/dev-local/notes'
alias lab='cd ~/dev-local/lab'
alias forks='cd ~/dev-local/forks'

# git
alias gs="git status"
alias gdc="git diff --cached"
alias gd="git diff"
alias gc="git commit"

# app academy
alias aa='cd ~/dev-local/main/aa'
alias irbload='irb -I . -r'
alias be='bundle exec'
alias aad='docker run -v "$(pwd)":/home/andy/aa/ -it ruby-env'

# utilities
alias ydl='youtube-dl -o "%(title)s.%(ext)s" -x --audio-format mp3 --audio-quality 0'
