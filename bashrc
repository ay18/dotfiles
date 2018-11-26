# .bashrc
# ==============================================================
# * https://github.com/sksea/dotfiles
# * andy.sksea@gmail.com

BASH_IMPORTS="$HOME/dev/dotfiles/bash"
for sh in $(find $BASH_IMPORTS -type f); do
  echo "sourcing $sh"
  . "$sh"
done

# CONFIG
# ---------------------------------------------------------------
EDITOR="code"
PLATFORM=$(uname -s)

# Prompt PS1
CLR="\[$(tput sgr0)\]"
C_BLUE="$CLR\[\033[38;5;39m\]"
C_YELLOW="$CLR\[\033[38;5;228m\]"
C_RED="$CLR\[\033[38;5;203m\]"
TIME="$CLR\$(date +%H:%M:%S)"
TRI="$(echo -e '\xe2\x96\xb2')"
export PS1="\n$C_BLUE\W $C_YELLOW$TRI $TIME$C_RED\$(parse_git_branch)\n> $CLR"

# PLUGINS
# ---------------------------------------------------------------

# Export PATH for homebrew.
export PATH="/usr/local/sbin:$PATH"
# brew bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then # brew dep
	. $(brew --prefix)/etc/bash_completion
fi

# python
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# nvm
export NVM_DIR="$HOME/.nvm"
if [[ -z "${NVM_BIN}" ]]; then
  . "/usr/local/opt/nvm/nvm.sh"
fi

# composer
export PATH="$PATH:$HOME/.composer/vendor/bin"

# laravel homestead
function homestead() {
    ( cd ~/Homestead && vagrant $* )
}

# fzf
[ -f ~/.fzf.bash  ] && source ~/.fzf.bash
# remap fzf in bash.
if [ $BASH_VERSINFO -gt 3  ]; then
  bind -r "\C-t"
  bind -x '"\C-f": "fzf-file-widget"'
fi
export FZF_DEFAULT_OPTS='--no-height --no-reverse'

# direnv
eval "$(direnv hook bash)"

# Git branch in prompt.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# git auto-complete
export LC_ALL=C
source "/usr/local/etc/bash_completion.d/git-completion.bash"


# ALIASES
# ---------------------------------------------------------------

# system
alias ls='ls -FG'
alias mkdir='mkdir -p'

# dev
alias pipls='pip list --format=columns'
alias npmls='npm -g ls --depth=0'
alias npmu='npm-check-updates'
alias g++='g++ -Wall -Wconversion -pedantic -std=c++11'
alias be='bundle exec'

alias gco='git checkout'
alias glg='git log -8'
alias gcm='git commit'
alias gst='git status'

# files
alias hosts='sudo $EDITOR /etc/hosts'
alias vimrc='$EDITOR ~/.vimrc'
alias bashrc='$EDITOR ~/.bashrc'
alias reload='. ~/.bashrc'
alias irbrc='$EDITOR ~/.irbrc'
alias dotfiles='cd ~/dev/dotfiles'
alias notes='code ~/dev/notes'

# directories
alias dev='cd ~/dev'
alias proj='cd ~/dev/projects'
alias lab='cd ~/dev/lab'
alias sb='cd ~/dev/sandbox'
alias archive='cd ~/dev/archive'
alias journal='cd ~/journal && code ~/journal'
alias cellar='cd /usr/local/Cellar'
alias books='cd ~/Google\ Drive/books'
