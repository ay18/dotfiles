#!/usr/bin/env bash

# bash functions to be called from other tools
# ====================================================================
# - https://github.com/ay18/dotfiles
# - andyych88@gmail.com

ghblame() {
  _open_repo $1 $2 "blame"
}

gh() {
  _open_repo $1 $2 "blob"
}

_open_repo() {
  origin=$(git remote get-url origin)
  if echo $origin | grep -q "https" 2>/dev/null ; then
    pattern="(?<=\.com/).*(?=.git)"
  else
    pattern="(?<=:).*(?=.git)"
  fi

  try_install grep # uses newer version of grep
  repo=$(echo $origin | ggrep -oP $pattern)
  url="https://github.com/$repo/$3/master/$1#L$2"

  echo "[Github] Opening url: $url with pattern: $pattern"
  open $url
}

. ~/.bashrc
if declare -f "$1" > /dev/null ; then
  "$@"
else
  echo "'$1' is not defined" >&2
fi
