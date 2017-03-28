
#                 =====================
#                ||     Andy Yee      ||
#                ||      bashrc       ||
#                 =====================

#=============================================================
# CONFIG
#=============================================================
EDITOR="vim"

# Bash prompt PS1
# colors
clr="\[$(tput sgr0)\]"
c0="$clr\[\033[38;5;39m\]"
c1="$clr\[\033[38;5;228m\]"
c2="$clr\[\033[38;5;203m\]"
triangle="`echo -e '\u25B2'`"

# prompt
export PS1="\n$c0\u $c2$triangle $c1\W $c2\$(parse_git_branch)\n> $clr"

# Set terminal tab name to current directory.
export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'

#=============================================================
# PLUGINS
#=============================================================

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

# direnv
eval "$(direnv hook bash)"

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

#=============================================================
# ALIASES
#=============================================================

# general bash commands
alias rm='rmtrash'
alias ls='ls -aFG'
alias mkdir='mkdir -p'

# dev tools
alias pip='pip3'
alias pipls='pip list --format=columns'
alias npmls='npm -g ls --depth=0'
alias npmu='npm-check-updates'
alias g++='g++ -Wall -Wconversion -pedantic -std=c++11'
alias webpack='webpack --config webpack.config.prod.js --watch'
alias webpackdev='webpack-dev-server --config webpack.config.dev.js --watch'
#alias python='python3'

# applications
alias ydl='youtube-dl -o "%(title)s.%(ext)s" -x --audio-format mp3'

# files
alias hosts='sudo $EDITOR /etc/hosts'
alias vimrc='$EDITOR ~/.vimrc'
alias bashrc='$EDITOR ~/.bashrc'
alias irbrc='$EDITOR ~/.irbrc'
alias envvars='$EDITOR ~/.global_env_vars.sh'

# directories
alias drive='cd ~/Google\ Drive'
alias cellar='cd /usr/local/Cellar'
alias devgd='cd ~/Google\ Drive/dev'

# symlinked directories (remember to symlink these in ~ for convenience)
alias dotfiles='cd ~/Google\ Drive/dev/dotfiles'

# personal project directories
alias dev='cd ~/dev-local/personal'
alias sb='cd ~/dev-local/sandbox'
alias notes='cd ~/dev-local/notes'
alias lab='cd ~/dev-local/lab'

# school
#alias bing='ssh ayee5@remote.cs.binghamton.edu'
#alias school='cd ~/Google\ Drive/school-2015-fall/'
#alias mntoop='cd ~/Develop/mount/ayee5/oop-fall-15'     # sshfs
#alias mntpl='cd ~/Develop/mount/ayee5/pl-fall-15'       # sshfs
#alias rmntbing='sshfs ayee5@remote.cs.binghamton.edu:/import/linux/home/ayee5/Desktop ~/Develop/mount/ayee5'
#alias umntbing='umount ~/Develop/mount/ayee5'
