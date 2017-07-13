if [ -f ~/.bashrc  ]; then
  source ~/.bashrc
fi

eval "$(rbenv init -)"

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

