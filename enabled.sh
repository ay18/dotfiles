export PRIVATE_DOTFILES=(
  "local.sh"
)
for file in "${PRIVATE_DOTFILES[@]}"; do
  echo "sourcing private $file"
  source "$DEV/private_dotfiles/src/$file"
done
