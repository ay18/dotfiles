
#                 =====================
#                ||     Andy Yee      ||
#                ||   Bash Profile    ||
#                 =====================

#=============================================================
# CONFIG
#=============================================================
EDITOR="vim"

# bash prompt
export PS1="\n\[\033[38;5;86m\]\u\[$(tput sgr0)\] @ \[\033[38;5;86m\]\w\[$(tput sgr0)\]\[\033[38;5;9m\]\$(parse_git_branch)\[$(tput sgr0)\]\n$ \[$(tput sgr0)\]"


# set terminal tab name to current directory
export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'

# environment variables
if [ "$(ls -A ~/env-vars)" ]; then
  for f in ~/env-vars/*; do source $f; done
fi

#=============================================================
# PLUGINS
#=============================================================

# golang
export GOPATH=$HOME/golang
export PATH=$PATH:$GOPATH/bin

# fzf
[ -f ~/.fzf.bash  ] && source ~/.fzf.bash

# brew-bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then # brew dep
	. $(brew --prefix)/etc/bash_completion
fi

# Git-bash completion
source ~/.git-completion.bash

# Git branch in prompt.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Google Cloud SDK
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc'


#=============================================================
# ALIASES
#=============================================================

# general bash commands
alias rm='rmtrash'
alias ls='ls -a'
alias mkdir='mkdir -p'

# dev tools
alias pip='pip3'
alias npmls='npm -g ls --depth=0'
alias npmu='npm-check-updates'
alias g++='g++ -Wall -Wconversion -pedantic -std=c++11'
alias webpack='webpack --config webpack.config.prod.js --watch'
alias webpackdev='webpack-dev-server --config webpack.config.dev.js --watch'

# other tools

# files
alias hosts='sudo $EDITOR /etc/hosts'
alias profile='$EDITOR ~/.bash_profile'
alias setprofile='. ~/.bash_profile'
alias vimrc='$EDITOR ~/.vimrc'
alias bashrc='$EDITOR ~/.bashrc'
alias irbrc='$EDITOR ~/.irbrc'

# directories
alias drive='cd ~/Google\ Drive'
alias cellar='cd /usr/local/Cellar'
alias devgd='cd ~/Google\ Drive/_dev'

# symlinked directories (remember to symlink these in ~ for convenience)
alias dotfiles='cd ~/Google\ Drive/_dev/dotfiles'
alias envvars='cd ~/Google\ Drive/_dev/env-vars'

# personal project directories
alias dev='cd ~/dev-local/personal'
alias gowork='cd $GOPATH'
alias godev='cd $GOPATH/src/github.com/sksea'
alias learnreact='cd ~/dev-local/personal/learn-react'
alias learnrails='cd ~/dev-local/personal/learn-rails'

# posse commands
alias pgstart='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pgstop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'
alias fstart='foreman start -f Procfile-foreman'
alias mysql='mysql -u root -p'
alias rs='rails s -p '
alias rc='rails c'
alias rsstg='RAILS_ENV=staging rails s -p '
alias rcstg="RAILS_ENV=staging rails c"

# lirx commands
alias ngrok-linserv='ngrok http -host-header=rewrite devapi.localhost.local:3040'
alias restart-linserv='aptible restart --app lirx-main-staging'
alias ssh-linauth='aptible ssh --app lirx-auth-staging'
alias ssh-linserv='aptible ssh --app lirx-main-staging'

# posse directories
alias possedrive='cd ~/Google\ Drive/posse-drive'

# posse project directories
alias posse='cd ~/dev-local/posse'
alias dst='cd ~/dev-local/posse/download-site-template'
alias acustom='cd ~/dev-local/posse/acustom-server'
alias zargo='cd ~/dev-local/posse/zargo-api-server'
alias linserv='cd ~/dev-local/posse/lindenwood-server'
alias linauth='cd ~/dev-local/posse/lindenwood-auth-server'
alias feeti='cd ~/dev-local/posse/feeti-server'
alias oak='cd ~/dev-local/posse/posse-oak'

# school
#alias bing='ssh ayee5@remote.cs.binghamton.edu'
#alias school='cd ~/Google\ Drive/school-2015-fall/'
#alias mntoop='cd ~/Develop/mount/ayee5/oop-fall-15'     # sshfs
#alias mntpl='cd ~/Develop/mount/ayee5/pl-fall-15'       # sshfs
#alias rmntbing='sshfs ayee5@remote.cs.binghamton.edu:/import/linux/home/ayee5/Desktop ~/Develop/mount/ayee5'
#alias umntbing='umount ~/Develop/mount/ayee5'
