function ssht {
  ssh $1 -t tmux
}

alias tmuxclear='tmux ls | grep -v attached | cut -d : -f 1 | xargs -n1 tmux kill-session -t'

function ggrep {
  git log --grep="$1"
}

# add hostname to prompt if connected through ssh
export PROMPT="${SSH_TTY:+[%m] }$PROMPT"
