# Install script
# Andy Yee [andyych88@gmail.com] 2019

install_homebrew () {
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

try_install () {
  if [[ ! -a /usr/local/bin/$1 ]]; then
    echo "Installing $1..."
    brew install $1 || install_homebrew
  else
    echo "$1 is already installed."
  fi
}

config_osx () {
  defaults write com.apple.dock autohide-time-modifier -float 0.25;killall Dock
  defaults write -g InitialKeyRepeat -int 15 # normal minimum is 15 (225 ms)
  defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
}

try_install brew
brew bundle