# Install script
# ====================================================================
# - https://github.com/ay18/dotfiles
# - andyyee.dev@gmail.com

export EMAIL="andyyee.dev@gmail.com"
export DEV="$HOME/dev"

mkdir -p "$DEV/lab"
mkdir -p "$DEV/sandbox"
mkdir -p "$DEV/projects"

echo "brewing dependencies..."
brew bundle

echo "stowing symlinks..."
stow main --target="$HOME"
