function pdfltx {
  pdflatex $1.tex && rm -f *.aux *.log *.out *.nav *.snm *.toc && open $1.pdf
}

function pg {
  nohup pgweb --host localhost --user jedi --db $1 --listen $2 >/dev/null 2>&1 &
}

function erl-test {
  local TEST=$1
  make
  if [ "$?" = "0" ]; then
    PATH_REGEX="*test/$TEST*.erl"
    APP_DIR=$(find apps -path "$PATH_REGEX" | sed -E 's:(apps/[^/]+).*:\1:')
    cd $APP_DIR
    rebar eunit suites=$TEST
    cd -
  fi
}

function ggrep {
  git log --grep="$1"
}

# add hostname to prompt if connected through ssh
export PROMPT="${SSH_TTY:+[%m] }$PROMPT"

