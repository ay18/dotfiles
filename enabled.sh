export PRIVATE_DOTFILES=(
  "local.sh"
)
for file in "${PRIVATE_DOTFILES[@]}"; do
#  echo "sourcing private $file" # disabled, breaks scp
  source "$DEV/private_dotfiles/envs/$file"
done
