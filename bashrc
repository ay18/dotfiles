# .bashrc
# ==============================================================
# * https://github.com/sksea/dotfiles
# * andy.sksea@gmail.com

BASH_IMPORTS=$(find ~/dev/dotfiles/bash -type f)
for sh in $BASH_IMPORTS; do
  echo "dotting $sh"
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
TRI="$(echo -e '\xe2\x96\xb2')"
export PS1="\n$C_BLUE\W $C_YELLOW$TRI$C_RED\$(parse_git_branch)\n> $CLR"

# PLUGINS
# ---------------------------------------------------------------

# Update PATH for homebrew.
export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"

# python
export PYTHON_CONFIGURE_OPTS="--enable-framework"
eval "$(pyenv init -)"

# nvm
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

# composer
export PATH="$PATH:$HOME/.composer/vendor/bin"

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

# brew-bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then # brew dep
	. $(brew --prefix)/etc/bash_completion
fi

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

# files
alias hosts='sudo $EDITOR /etc/hosts'
alias vimrc='$EDITOR ~/.vimrc'
alias bashrc='$EDITOR ~/.bashrc'
alias reload='. ~/.bashrc'
alias irbrc='$EDITOR ~/.irbrc'
alias dotfiles='cd ~/dev/dotfiles'
alias notes='cd ~/dev/main/notes && code ~/dev/main/notes'

# directories
alias dev='cd ~/dev'
alias proj='cd ~/dev/projects'
alias lab='cd ~/dev/lab'
alias sb='cd ~/dev/sandbox'
alias archive='cd ~/dev/archive'
alias journal='cd ~/journal && code ~/journal'
alias cellar='cd /usr/local/Cellar'
alias books='cd ~/Google\ Drive/books'
