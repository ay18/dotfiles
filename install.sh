# Install script
# Andy Yee [andyych88@gmail.com] 2019

brews=(
  brew
  zsh
  fzf
  direnv
  jenv
  npm
)

casks=(
  spotify
  whatsapp
  phpstorm
  visual-studio-code
  postman
)

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

try_install_cask () {
  if brew cask list $1 -eq 0 &>/dev/null; then
    echo "Installing $1..."
    brew cask install $1
  else
    echo "$1 is already installed."
  fi
}

# Begin installation.
for x in $brews; do
  try_install $x
done
for x in $casks; do
  try_install_cask $x
done