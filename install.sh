# Install script
# ====================================================================
# - https://github.com/ay18/dotfiles
# - andyyee.dev@gmail.com

export EMAIL="andyyee.dev@gmail.com"
export DEV="$HOME/dev"

generate_ssh_key() {
  ssh-keygen -t rsa -b 4096 -C $EMAIL
  ssh-add -K ~/.ssh/id_rsa
  pbcopy < ~/.ssh/id_rsa.pub
}

config_osx() {
  defaults write com.apple.dock autohide-time-modifier -float 0.25;killall Dock
  defaults write com.apple.finder AppleShowAllFiles YES;killall Finder
  defaults write -g InitialKeyRepeat -int 15 # normal minimum is 15 (225 ms)
  defaults write -g KeyRepeat -int 2 # normaddl minimum is 2 (30 ms)
}

config_git() {
  # email and name might be different per environment
  git config --global core.excludesfile $HOME/.gitignore_global
  git config --global merge.tool vscode
  git config --global mergetool.vscode.cmd "code --wait $MERGED"
  git config --global diff.tool vscode
  git config --global difftool.vscode.cmd "code --wait --diff $LOCAL $REMOTE"
}

create_dirs() {
  mkdir -p "$DEV/lab"
  mkdir -p "$DEV/sandbox"
  mkdir -p "$DEV/projects"
}

setup_all() {
  create_dirs
  git clone git@github.com:ay18/private_dotfiles.git ~/dev/private_dotfiles
  config_osx
  config_git
}

if [[ ! -a /usr/local/bin/brew ]]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
echo "brewing dependencies..."
brew bundle
echo "stowing symlinks..."
stow main --target="$HOME"
setup_all
