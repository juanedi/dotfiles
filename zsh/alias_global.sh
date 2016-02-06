alias eps='ps aux | grep -i'
alias l='ls -w1'
alias ll='ls -l'
alias l1='ls -w1'
alias lsd='tree -d -L 1'
alias "...."="cd ../../.."
alias trim="sed \"s/^ *//g;s/ *$//g\""
alias quote="sed 's/^/\"/g' | sed 's/$/\"/g'"

alias jfind="find . | grep \.java$ | grep "
alias jgrep="find . | grep -v target | grep java | xargs grep "
alias igrep="grep -i"

alias hgrep="history | grep -i"
alias rgrep="grep -r"
alias matchingfiles="cut -d ':' -f 1 | sort | uniq"

# alias cleantex='svn st | cut -c 9- | grep -e \.aux$ -e \.log$ -e \.out$ -e \.nav$ -e \.snm$ -e \.toc$ | xargs rm'
alias cleantex='git status | grep -v modified | grep -e \.aux$ -e \.log$ -e \.out$ -e \.nav$ -e \.snm$ -e \.toc$  | cut -c 2- | xargs rm'
alias be='bundle exec'

alias zshconfig="$EDITOR ~/.zshrc"
