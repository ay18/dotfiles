export PRIVATE_DOTFILES=(
  "local.sh"
)
for file in "${PRIVATE_DOTFILES[@]}"; do
  source "$DEV/private_dotfiles/envs/$file"
done
