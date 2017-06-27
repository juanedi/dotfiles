alias pi-music-down='rsync -rau --progress --delete --exclude=iTunes osmc@10.0.1.13:/media/samsung/music/ $HOME/Music'
alias pi-music-up='rsync -rau --progress --exclude=iTunes --perms $HOME/Music/ osmc@10.0.1.13:/media/samsung/music'
alias o='open .'
alias lstcp='lsof -i -n -P | grep TCP | grep LISTEN'
alias sshconfig="$EDITOR $HOME/.ssh/config"
alias dm='docker-machine'
alias tmux-clear='tmux ls | grep -v attached | cut -d : -f 1 | xargs -n1 tmux kill-session -t'

alias dc='docker-compose'
alias dc-run='docker-compose run --rm'

function ssht {
  ssh $1 -t tmux
}

# add hostname to prompt if connected through ssh
export PROMPT="${SSH_TTY:+[%m] }$PROMPT"
