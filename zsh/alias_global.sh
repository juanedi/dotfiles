alias eps='ps aux | grep -i'
alias l='ls -w1'
alias ll='ls -l'
alias l1='ls -w1'
alias lsd='tree -d -L 1'
alias "...."="cd ../../.."
alias trim="sed \"s/^ *//g;s/ *$//g\""
alias quote="sed 's/^/\"/g' | sed 's/$/\"/g'"

alias igrep="grep -i"

alias hgrep="history | grep -i"
alias matchingfiles="cut -d ':' -f 1 | sort | uniq"

alias be='bundle exec'

alias v='view'

alias zshconfig="$EDITOR ~/.zshrc"
