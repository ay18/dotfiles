# Wayfair environment
# Andy Yee [cyee@wayfair.com] 2018

# https://git.csnzoo.com/wayfair/wf#installation
export FPATH="/Users/cyee/.wf/zsh-completion:$FPATH"
compinit

alias wfvm='ssh -t webphp0967.dev.bo1.csnzoo.com bash -l'
alias snippets='cd ~/dev/wf-snippets'
alias wfsnip='cd ~/dev/wf-snippets'
alias codebase='cd ~/codebase'
alias wfcode='cd ~/codebase'
alias wfres='cd ~/codebase/resources'
alias wfphp='cd ~/codebase/php'
alias wfdb='cd ~/codebase/db'
alias wfand='cd ~/codebase/tangerine-mobile'
alias wfpost='wf reviewboard post'
alias wfsnip='code ~/dev/wf-snippets'

tmreset() {
  tmux select-layout tiled
}

wfsync() {
  realsync ~/codebase
}

wfdebug() {
  wfphp && wf enable xdebug-tunnel
}

wms_docker_up() {
  cd ~/docker-sql-server && docker-compose -p dev up
}

wfs() {
  cd ~/dev/; tmux new-session -d -s wfdev -n window
  for _ in {1..3}
    do
      tmux send-keys -t wfdev:window 'tmux split-window -h' Enter
  done
  tmux send-keys -t wfdev:window 'tmux send-keys -t 0.0 "tmux select-layout tiled" Enter' Enter
  tmux send-keys -t wfdev:window 'tmux send-keys -t 0.1 "wfdebug" Enter' Enter 
  tmux send-keys -t wfdev:window 'tmux send-keys -t 0.2 "wms_docker_up" Enter' Enter
  tmux send-keys -t wfdev:window 'tmux send-keys -t 0.3 "wfsync" Enter' Enter
  tmux send-keys -t wfdev:window 'tmux select-pane -t 0.0' Enter
  tmux attach -t wfdev:window
}

wfe() {
  tmux kill-server
}

wfpull() {
  current_branch=$(git rev-parse --abbrev-ref HEAD) \
    && git checkout master \
    && git pull \
    && git checkout $current_branch
}

wfrebase() {
  git rebase -i $(git rev-parse origin/master)
}

wfdeploy() {
  wf sniff \
    && wfpull \
    && wfrebase \
    && git push -uf origin $current_branch
}