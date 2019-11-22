# Install script
# Andy Yee [andyych88@gmail.com] 2019

EMAIL="andyych88@gmail.com"


install_homebrew() {
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

try_install() {
  if [[ ! -a /usr/local/bin/$1 ]]; then
    echo "Installing $1..."
    brew install $1 || install_homebrew
  else
    echo "$1 is already installed."
  fi
}

config_osx() {
  defaults write com.apple.dock autohide-time-modifier -float 0.25;killall Dock
  defaults write com.apple.finder AppleShowAllFiles YES;killall Finder
  defaults write -g InitialKeyRepeat -int 15 # normal minimum is 15 (225 ms)
  defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
}

config_git() {
  ssh-keygen -t rsa -b 4096 -C $EMAIL
  ssh-add -K ~/.ssh/id_rsa
  pbcopy < ~/.ssh/id_rsa.pub
  git config --global user.name "Andy Yee"
  git config --global user.email $EMAIL
  git config --global core.excludesfile ~/dev/dotfiles/git/.gitignore_global
}

try_install brew
brew bundle
config_osx
config_git