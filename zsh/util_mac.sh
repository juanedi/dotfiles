function ssht {
  ssh $1 -t tmux
}

function ggrep {
  git log --grep="$1"
}

# add hostname to prompt if connected through ssh
export PROMPT="${SSH_TTY:+[%m] }$PROMPT"
