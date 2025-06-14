# .zshrc for OS X and Linux
# ====================================================================
# - https://github.com/ay18/dotfiles
# - andyyee.dev@gmail.com

export EMAIL="andyyee.dev@gmail.com"
export DEV="$HOME/dev"
export DOTFILES="$DEV/dotfiles"
export PLATFORM=$(uname -s)
export EDITOR=vim

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--no-height --no-reverse'

if [ $(uname -p) = 'arm' ]; then
  export ARM=true
fi


# brew Apple silicon
if [ "$ARM" = true ]; then
  export PATH=/opt/homebrew/bin:$PATH
  eval "$(/opt/homebrew/bin/brew shellenv)"
  . /opt/homebrew/opt/asdf/libexec/asdf.sh
fi

if [ "$PLATFORM" = 'Linux' ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  . /home/linuxbrew/.linuxbrew/opt/asdf/libexec/asdf.sh
fi

# brew autocomplete
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

# Environment
# --------------------------------------------------------------------

# zsh automcomplete
autoload -Uz compinit
compinit
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

# zoxide
eval "$(zoxide init zsh)"

# starship
export STARSHIP_CONFIG=~/.config/starship.toml
eval "$(starship init zsh)"

# zsh syntax highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh autosuggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# direnv
[ -f "`which direnv`" ] && eval "$(direnv hook zsh)"

# setting compiler flags to be able to find brew dependencies
# TODO: `brew --prefix` is really slow, remove redundant calls here.
# export PATH="$(brew --prefix openssl)/bin:$PATH"
# export CFLAGS="-I$(brew --prefix openssl)/include"
# export CPPFLAGS="-I$(brew --prefix openssl)/include -I/opt/homebrew/opt/openblas/include"
# export LDFLAGS="-L$(brew --prefix openssl)/lib -L/opt/homebrew/opt/openblas/lib"

export GRPC_PYTHON_BUILD_SYSTEM_OPENSSL=1
export GRPC_PYTHON_BUILD_SYSTEM_ZLIB=1


# Functions
# --------------------------------------------------------------------
get_current_branch () {
  current_branch="$(git rev-parse --abbrev-ref HEAD)"
  echo $current_branch
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
    selection=$(git branch | fzf)
    if [ -z $selection ]; then
      return 1
    fi

    echo $selection | xargs -I {} git checkout {}
  else
    git checkout $@
  fi
}

gpu () {
  git push -u origin $(get_current_branch)
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

timestamp () {
  date +%s
}


# Keybinds
# --------------------------------------------------------------------

# bindkey -s '©' 'lazygit^M'
# bindkey -s 'ª' 'k9s^M'

# Aliases
# --------------------------------------------------------------------

# files
alias hosts="sudo $EDITOR /etc/hosts"
alias vimrc="$EDITOR $HOME/.vimrc"
alias bashrc="$EDITOR $HOME/.bashrc"
alias zshrc="$EDITOR $HOME/.zshrc"
alias reload=". $HOME/.zshrc"

# directories
alias dev="cd $DEV"
alias dot="cd $DOTFILES"
alias pdot="cd $DEV/private_dotfiles"
alias prj="cd $DEV/projects"
alias lab="cd $DEV/lab"
alias sb="cd $DEV/sandbox"
alias csr="cursor"

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
alias grh!="git reset --hard"
alias gcl!='git checkout . && git clean -f'
alias gc="git commit"
alias gs="git status"
alias gcp="git cherry-pick"
alias gw="git worktree"

alias brew64="arch -x86_64 brew"

if [ ! -d "$DEV/private_dotfiles" ]; then
  echo "$DEV/private_dotfiles doesn't exist. cloning."
  git clone git@github.com:ay18/private_dotfiles.git $DEV/private_dotfiles
fi

if [ ! -s "$DEV/enabled.sh" ]; then
  echo "$DEV/enabled.sh doesn't exist. creating."
  cp $DOTFILES/enabled.sh $DEV/enabled.sh
fi
source $DEV/enabled.sh

# AWS EKS
# https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html
export PATH=$PATH:$HOME/bin

# Added by serverless binary installer
export PATH="$HOME/.serverless/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/andyyee/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

. "/Users/andyyee/.deno/env"
