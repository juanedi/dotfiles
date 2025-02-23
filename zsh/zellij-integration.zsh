if [[ ! -f "$HOME/.nozellij" && -z "$ZELLIJ" ]]; then
    if [[ "$ITERM_PROFILE" == "NRI Services" ]]; then
        zellij a nri-services || zellij --layout nri -s nri-services
    elif [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
        zellij attach -c
    else
        # need set TERM explicitly because zellij will otherwise echo back the
        # base part of each command, not sure why.
        TERM=xterm-256color zellij
    fi

    exit 0
fi
