alias sublime='subl'
alias xopen='open'
alias gitx='open -a gitx .'
alias pi-music-down='rsync -rau --progress --delete --exclude=iTunes pi@10.0.1.13:/mnt/PASSPORT/music/ $HOME/Music'
alias pi-music-up='rsync -rau --progress --exclude=iTunes --perms $HOME/Music/ pi@10.0.1.13:/mnt/PASSPORT/music'
alias o='open .'
alias lstcp='lsof -i -n -P | grep TCP | grep LISTEN'
alias sshconfig='subl $HOME/.ssh/config'

alias dm='docker-machine'
alias dc='docker-compose'

function dsh {
  docker-compose run $1 /bin/bash
}
