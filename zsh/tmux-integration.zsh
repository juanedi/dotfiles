random-word() {
    perl -e 'open IN, "</usr/share/dict/words";rand($.) < 1 && ($n=$_) while <IN>;print $n'
}

tmux-is-session-attached() {
    tmux info && tmux list-sessions | grep "^$1: " | grep "(attached)$"
}

tmux-create-session() {
    name=$(basename `pwd` | sed -e 's/\.//g')

    # if well-known session is detached, attach to it (or create it if necessary).
    # otherwise, create a new one with a random name.
    if tmux-is-session-attached $name
    then
        # another client is already attached to that session
        tmux new-session -s `random-word`
    else
        # either the session is not created or no one is attached
        tmux attach -t $name || tmux new-session -s $name
    fi
}

if [ -z "$TMUX" ]; then
    # enter tmux!
    # either attach to well-known session or create a new one
    tmux-create-session &> /dev/null

    # after we are done, exit
    exit 0
fi
