# Install script
# ====================================================================
# - https://github.com/ay18/dotfiles
# - andyych88@gmail.com
export EMAIL="andyych88@gmail.com"

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

try_install # brew
brew bundle
config_osx
config_git