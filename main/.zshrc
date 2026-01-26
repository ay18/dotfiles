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
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

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
  git fetch origin
  git rebase origin/main
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

gcob() {
  # Usage: gcob [-b base_branch] <new_branch_name>
  # Creates a new branch off of origin/main (or specified base branch) and pushes it to origin.
  local base_branch="main"
  local opt
  local OPTIND=1

  while getopts ":b:" opt; do
    case ${opt} in
      b)
        base_branch=$OPTARG
        ;;
      \?)
        echo "Invalid option: -$OPTARG" >&2
        return 1
        ;;
      :)
        echo "Option -$OPTARG requires an argument." >&2
        return 1
        ;;
    esac
  done
  shift $((OPTIND -1))

  local name="$1"
  if [[ -z "$name" ]]; then
    echo "usage: gcob [-b base_branch] <branch-name>" >&2
    return 2
  fi
  git rev-parse --git-dir >/dev/null 2>&1 || { echo "not a git repo" >&2; return 2; }
  git fetch origin "$base_branch" || return 1
  if git show-ref --verify --quiet "refs/heads/$name"; then
    echo "local branch exists: $name" >&2
    return 1
  fi
  if git ls-remote --heads origin "$name" | grep -q .; then
    echo "remote branch exists: origin/$name" >&2
    return 1
  fi
  git switch -c "$name" "origin/$base_branch" || return 1
  git push -u origin "$name"
}

gpu () {
  git push -u origin $(get_current_branch)
}

gpu! () {
  git push -uf origin $(get_current_branch)
}

# gdpu! - delete remote branch
# Usage: gdpu! [branch] - deletes branch from origin (defaults to current branch)
gdpu! () {
  local branch="${1:-$(get_current_branch)}"
  git push origin --delete "$branch"
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
alias c="claude"
alias ccc="claude -p"

alias ..="cd .."
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
alias gwl="git worktree list"

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
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

. "/Users/andyyee/.deno/env"

# iterm
precmd() {
    echo -ne "\033]0;${PWD##*/}\007"
}

# Go binaries
export PATH="$PATH:$(go env GOPATH)/bin"

export PATH="$HOME/.local/bin:$PATH"
